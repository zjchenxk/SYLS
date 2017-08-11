using System;
using System.Collections;
using System.Collections.Generic;

namespace SYLS.Helper
{
    /// <summary>
    /// 计算器
    /// </summary>
    public class EvaluatorHelper
    {
        private string strInFix = null;
        private Dictionary<string, string> arrVars = null;
        private string[] arrTokens = null;
        private string[] arrPostFix = null;
        private string dtFormat = "dd/MM/yyyy";
        private string lstAlpha = "a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z";
        private string lstDigits = "0,1,2,3,4,5,6,7,8,9";
        private string lstArithOps = "^,*,/,%,+,-";
        private string lstLogicOps = "!,&,|";
        private string lstCompaOps = "<,<=,>,>=,<>,=";
        private string[] lstFuncOps = { "AVG", "ABS", "ACOS", "ASC", "ASIN", "ATAN", "CDATE", "CHR", "COS", "DATE", "FIX", "HEX", "IIF", "LCASE", "LEFT", "LOG", "MAX", "MID", "MIN", "RIGHT", "ROUND", "SIN", "SQRT", "TAN", "UCASE", "INT" };
        private const string ARG_TERMINAL = "Ø";
        private const string UNARY_NEG = "­";

        public void SetDateFormat(string pstrFmt)
        {
            dtFormat = pstrFmt;
        }

        public void SetExpression(string pstrExp)
        {
            strInFix = pstrExp;
        }

        public void AddVariable(string varName, string varValue)
        {
            if (arrVars == null)
                arrVars = new Dictionary<string, string>();
            arrVars[varName] = varValue;
        }

        // postfix function evaluator
        public string EvaluateExpression()
        {
            int intIndex;
            Stack myStack;
            string strTok, strOp;
            string objOp1, objOp2, objTmp1, objTmp2;
            string dblNo, dblVal1, dblVal2;

            if (arrPostFix == null)
                ParseExpression();

            if (arrPostFix.Length == 0)
                throw new Exception("Unable to parse the expression!");

            string[] parrExp = arrPostFix;
            if (parrExp == null)
            {
                throw new Exception("Invalid postfix expression!");
            }
            if (parrExp.Length == 0)
            {
                throw new Exception("Invalid postfix expression!");
            }

            intIndex = 0;
            myStack = new Stack();
            while (intIndex < parrExp.Length)
            {
                strTok = parrExp[intIndex];
                switch (strTok)
                {
                    case ARG_TERMINAL:
                        myStack.Push(strTok);
                        break;
                    case UNARY_NEG:
                        if (myStack.Count == 0)
                            throw new Exception("No operand to negate!");

                        objOp1 = null;
                        objOp2 = null;
                        objOp1 = myStack.Pop().ToString();
                        if (IsVariable(objOp1))
                            objOp1 = GetVariable(objOp1);

                        dblNo = ToNumber(objOp1);
                        if (dblNo == null)
                            throw new Exception("Not a numaric value!");
                        else
                        {
                            dblNo = (0 - double.Parse(dblNo)).ToString();
                            myStack.Push(dblNo);
                        }
                        break;
                    case "!":
                        if (myStack.Count == 0)
                            throw new Exception("No operand on stack!");

                        objOp1 = null;
                        objOp2 = null;
                        objOp1 = myStack.Pop().ToString();
                        if (IsVariable(objOp1))
                            objOp1 = GetVariable(objOp1);

                        objOp1 = ToBoolean(objOp1);
                        if (objOp1 == null)
                            throw new Exception("Not a boolean value!");
                        else
                            myStack.Push(!bool.Parse(objOp1));
                        break;
                    case "*":
                    case "/":
                    case "%":
                    case "^":
                        if (myStack.Count == 0 || myStack.Count < 2)
                            throw new Exception("Stack is empty, can not perform [" + strTok + "]");
                        objOp1 = null;
                        objOp2 = null;
                        objOp2 = myStack.Pop().ToString();
                        objOp1 = myStack.Pop().ToString();
                        if (IsVariable(objOp1))
                            objOp1 = GetVariable(objOp1);
                        if (IsVariable(objOp2))
                            objOp2 = GetVariable(objOp2);

                        dblVal1 = ToNumber(objOp1);
                        dblVal2 = ToNumber(objOp2);
                        if (dblVal1 == null || dblVal2 == null)
                            throw new Exception("Either one of the operand is not a number can not perform [" + strTok + "]");
                        if (strTok == "^")
                            myStack.Push(Math.Pow(double.Parse(dblVal1), double.Parse(dblVal2)));
                        else if (strTok == "*")
                        {
                            myStack.Push((double.Parse(dblVal1) * double.Parse(dblVal2)));
                        }
                        else if (strTok == "/")
                        {
                            myStack.Push((double.Parse(dblVal1) / double.Parse(dblVal2)));
                        }
                        else
                        {
                            myStack.Push((double.Parse(dblVal1) % double.Parse(dblVal2)));
                        }
                        break;
                    case "+":
                    case "-":
                        if (myStack.Count == 0 || myStack.Count < 2)
                            throw new Exception("Stack is empty, can not perform [" + strTok + "]");
                        objOp1 = null;
                        objOp2 = null;
                        objTmp1 = null;
                        objTmp2 = null;
                        strOp = ((strTok == "+") ? "Addition" : "Substraction");
                        objOp2 = myStack.Pop().ToString();
                        objOp1 = myStack.Pop().ToString();
                        if (IsVariable(objOp1))
                            objOp1 = GetVariable(objOp1);
                        if (IsVariable(objOp2))
                            objOp2 = GetVariable(objOp2);

                        if (IsBoolean(objOp1) || IsBoolean(objOp2))
                            throw new Exception("Can not perform " + strOp + " with boolean values!");
                        else if (IsDate(objOp1) && IsDate(objOp1))
                            throw new Exception(strOp + " of two dates not supported!");
                        else if (objOp1 == null || objOp2 == null)
                            throw new Exception(strOp + " of two null not supported!");
                        else if (IsNumber(objOp1) && IsNumber(objOp2))
                        {
                            // Number addition
                            dblVal1 = ToNumber(objOp1);
                            dblVal2 = ToNumber(objOp2);
                            if (strTok == "+")
                            {
                                myStack.Push((double.Parse(dblVal1) + double.Parse(dblVal2)));
                            }
                            else
                            {
                                myStack.Push((double.Parse(dblVal1) - double.Parse(dblVal2)));
                            }
                        }
                        else
                        {
                            if (strTok == "+")
                                myStack.Push((objOp1 + objOp2));
                            else
                                throw new Exception(strOp + " not supported for strings!");
                        }
                        break;
                    case "=":
                    case "<":
                    case ">":
                    case "<>":
                    case "<=":
                    case ">=":
                        if (myStack.Count == 0 || myStack.Count < 2)
                            throw new Exception("Stack is empty, can not perform [" + strTok + "]");
                        objOp1 = null;
                        objOp2 = null;
                        objTmp1 = null;
                        objTmp2 = null;
                        objOp2 = myStack.Pop().ToString();
                        objOp1 = myStack.Pop().ToString();
                        if (IsVariable(objOp1))
                            objOp1 = GetVariable(objOp1);
                        if (IsVariable(objOp2))
                            objOp2 = GetVariable(objOp2);

                        if (IsNumber(objOp1) && IsNumber(objOp2))
                        {
                            dblVal1 = ToNumber(objOp1);
                            dblVal2 = ToNumber(objOp2);
                            if (strTok == "=")
                                myStack.Push((double.Parse(dblVal1) == double.Parse(dblVal2)));
                            else if (strTok == "<>")
                                myStack.Push((double.Parse(dblVal1) != double.Parse(dblVal2)));
                            else if (strTok == ">")
                                myStack.Push((double.Parse(dblVal1) > double.Parse(dblVal2)));
                            else if (strTok == "<")
                                myStack.Push((double.Parse(dblVal1) < double.Parse(dblVal2)));
                            else if (strTok == "<=")
                                myStack.Push((double.Parse(dblVal1) <= double.Parse(dblVal2)));
                            else if (strTok == ">=")
                                myStack.Push((double.Parse(dblVal1) >= double.Parse(dblVal2)));
                        }
                        else if (IsBoolean(objOp1) && IsBoolean(objOp2) && (strTok == "=" || strTok == "<>"))
                        {
                            objTmp1 = ToBoolean(objOp1);
                            objTmp2 = ToBoolean(objOp2);
                            if (strTok == "=")
                                myStack.Push((bool.Parse(objTmp1) == bool.Parse(objTmp2)));
                            else if (strTok == "<>")
                                myStack.Push((bool.Parse(objTmp1) != bool.Parse(objTmp2)));
                        }
                        else if (IsDate(objOp1) && IsDate(objOp2))
                        {
                            objTmp1 = ToDate(objOp1, dtFormat);
                            objTmp2 = ToDate(objOp2, dtFormat);
                            if (strTok == "=")
                                myStack.Push((DateTime.Parse(objTmp1) == DateTime.Parse(objTmp2)));
                            else if (strTok == "<>")
                                myStack.Push((DateTime.Parse(objTmp1) != DateTime.Parse(objTmp2)));
                            else if (strTok == ">")
                                myStack.Push((DateTime.Parse(objTmp1) > DateTime.Parse(objTmp2)));
                            else if (strTok == "<")
                                myStack.Push((DateTime.Parse(objTmp1) < DateTime.Parse(objTmp2)));
                            else if (strTok == "<=")
                                myStack.Push((DateTime.Parse(objTmp1) <= DateTime.Parse(objTmp2)));
                            else if (strTok == ">=")
                                myStack.Push((DateTime.Parse(objTmp1) >= DateTime.Parse(objTmp2)));
                        }
                        else if (strTok == "=" || strTok == "<>")
                        {
                            if (strTok == "=")
                                myStack.Push((objOp1 == objOp2));
                            else if (strTok == "<>")
                                myStack.Push((objOp1 != objOp2));
                        }
                        else
                            throw new Exception("For " + strTok + " operator LHS & RHS should be of same data type!");
                        break;
                    case "&":
                    case "|":
                        if (myStack.Count == 0 || myStack.Count < 2)
                            throw new Exception("Stack is empty, can not perform [" + strTok + "]");
                        objOp1 = null;
                        objOp2 = null;
                        objTmp1 = null;
                        objTmp2 = null;
                        objOp2 = myStack.Pop().ToString();
                        objOp1 = myStack.Pop().ToString();
                        if (IsVariable(objOp1))
                            objOp1 = GetVariable(objOp1);
                        if (IsVariable(objOp2))
                            objOp2 = GetVariable(objOp2);

                        if (IsBoolean(objOp1) && IsBoolean(objOp2))
                        {
                            objTmp1 = ToBoolean(objOp1);
                            objTmp2 = ToBoolean(objOp2);
                            if (strTok == "&")
                                myStack.Push((bool.Parse(objTmp1) && bool.Parse(objTmp2)));
                            else if (strTok == "|")
                                myStack.Push((bool.Parse(objTmp1) || bool.Parse(objTmp2)));
                        }
                        else
                            throw new Exception("Logical operator requires LHS & RHS of boolean type!");
                        break;
                    default:
                        // Handle functions and operands
                        if (IsNumber(strTok) || IsBoolean(strTok) || IsDate(strTok) || IsVariable(strTok))
                        {
                            myStack.Push(strTok);
                        }
                        else
                        {
                            HandleFunctions(strTok, ref myStack, dtFormat, arrVars);
                        }
                        break;
                }
                intIndex++;
            }
            if (myStack.Count == 0 || myStack.Count > 1)
                throw new Exception("Unable to evaluate expression!");
            else
                return myStack.Pop().ToString();
        }

        public void ClearAll()
        {
            arrVars = null;
            strInFix = null;
            arrTokens = null;
            arrPostFix = null;
        }

        private string ParseExpression()
        {
            arrTokens = Tokanize(strInFix);
            if (arrTokens == null)
                throw new Exception("Unable to tokanize the expression!");
            if (arrTokens.Length <= 0)
                throw new Exception("Unable to tokanize the expression!");

            arrPostFix = InFixToPostFix(arrTokens);
            if (arrPostFix == null)
                throw new Exception("Unable to convert the expression to postfix form!");
            if (arrPostFix.Length <= 0)
                throw new Exception("Unable to convert the expression to postfix form!");
            return arrPostFix.ToString();
        }

        /*------------------------------------------------------------------------------
        * NAME       : Tokanize
        * PURPOSE    : Breaks the string into a token array. It also checks whether the
        *              parenthesis, single quotes and double quotes are balanced or not.
        * PARAMETERS : pstrExpression - The string from which token array is to be 
        *              constructed.
        * RETURNS    : An array of tokens.
        * THROWS     : Unterminated string constant - Single/Double quotes are not 
        *                                             properly terminated
        *              Unbalanced parenthesis - Opening/closing braces are not balanced
        *----------------------------------------------------------------------------*/
        private string[] Tokanize(string pstrExpression)
        {

            int intCntr, intBraces;
            List<string> arrTokens;
            int intIndex, intPos;
            string chrChar, chrNext;
            string strToken, prevToken;

            intCntr = 0;
            intBraces = 0;
            intIndex = 0;
            strToken = "";
            arrTokens = new List<string>();
            pstrExpression = pstrExpression.Trim();
            while (intCntr < pstrExpression.Length)
            {
                prevToken = "";
                chrChar = pstrExpression.Substring(intCntr, 1);
                switch (chrChar)
                {
                    case " ":
                        if (strToken.Length > 0)
                        {
                            arrTokens.Add(strToken);
                            intIndex++;
                            strToken = "";
                        }
                        break;
                    case "(":
                        intBraces++;
                        if (strToken.Length > 0)
                        {
                            arrTokens.Add(strToken);
                            intIndex++;
                            strToken = "";
                        }
                        arrTokens.Add(chrChar);
                        intIndex++;
                        break;
                    case ")":
                        intBraces--;
                        if (strToken.Length > 0)
                        {
                            arrTokens.Add(strToken);
                            intIndex++;
                            strToken = "";
                        }
                        arrTokens.Add(chrChar);
                        intIndex++;
                        break;
                    case "^":
                        if (strToken.Length > 0)
                        {
                            arrTokens.Add(strToken);
                            intIndex++;
                            strToken = "";
                        }
                        arrTokens.Add(chrChar);
                        intIndex++;
                        break;
                    case "*":
                        if (strToken.Length > 0)
                        {
                            arrTokens.Add(strToken);
                            intIndex++;
                            strToken = "";
                        }
                        arrTokens.Add(chrChar);
                        intIndex++;
                        break;
                    case "/":
                        if (strToken.Length > 0)
                        {
                            arrTokens.Add(strToken);
                            intIndex++;
                            strToken = "";
                        }
                        arrTokens.Add(chrChar);
                        intIndex++;
                        break;
                    case "%":
                        if (strToken.Length > 0)
                        {
                            arrTokens.Add(strToken);
                            intIndex++;
                            strToken = "";
                        }
                        arrTokens.Add(chrChar);
                        intIndex++;
                        break;
                    case "&":
                        if (strToken.Length > 0)
                        {
                            arrTokens.Add(strToken);
                            intIndex++;
                            strToken = "";
                        }
                        arrTokens.Add(chrChar);
                        intIndex++;
                        break;
                    case "|":
                        if (strToken.Length > 0)
                        {
                            arrTokens.Add(strToken);
                            intIndex++;
                            strToken = "";
                        }
                        arrTokens.Add(chrChar);
                        intIndex++;
                        break;
                    case ",":
                        if (strToken.Length > 0)
                        {
                            arrTokens.Add(strToken);
                            intIndex++;
                            strToken = "";
                        }
                        arrTokens.Add(chrChar);
                        intIndex++;
                        break;
                    case "-":
                        if (strToken.Length > 0)
                        {
                            arrTokens.Add(strToken);
                            intIndex++;
                            strToken = "";
                        }
                        chrNext = pstrExpression.Substring(intCntr + 1, 1);
                        if (arrTokens.Count > 0)
                            prevToken = arrTokens[intIndex - 1];
                        if (intCntr == 0 || ((IsOperator(prevToken) || prevToken == "(" || prevToken == ",") && (IsDigit(chrNext) || chrNext == "(")))
                        {
                            // Negative Number
                            strToken += chrChar;
                        }
                        else
                        {
                            arrTokens.Add(chrChar);
                            intIndex++;
                            strToken = "";
                        }
                        break;
                    case "+":
                        if (strToken.Length > 0)
                        {
                            arrTokens.Add(strToken);
                            intIndex++;
                            strToken = "";
                        }
                        chrNext = pstrExpression.Substring(intCntr + 1, 1);
                        if (arrTokens.Count > 0)
                            prevToken = arrTokens[intIndex - 1];
                        if (intCntr == 0 || ((IsOperator(prevToken) || prevToken == "(" || prevToken == ",") && (IsDigit(chrNext) || chrNext == "(")))
                        {
                            // positive Number
                            strToken += chrChar;
                        }
                        else
                        {
                            arrTokens.Add(chrChar);
                            intIndex++;
                            strToken = "";
                        }
                        break;
                    case "<":
                        chrNext = pstrExpression.Substring(intCntr + 1, 1);
                        if (strToken.Length > 0)
                        {
                            arrTokens.Add(strToken);
                            intIndex++;
                            strToken = "";
                        }
                        if (chrNext == "=")
                        {
                            arrTokens.Add(chrChar + "=");
                            intIndex++;
                            intCntr++;
                        }
                        else if (chrNext == ">")
                        {
                            arrTokens.Add(chrChar + ">");
                            intIndex++;
                            intCntr++;
                        }
                        else
                        {
                            arrTokens.Add(chrChar);
                            intIndex++;
                        }
                        break;
                    case ">":
                        chrNext = pstrExpression.Substring(intCntr + 1, 1);
                        if (strToken.Length > 0)
                        {
                            arrTokens.Add(strToken);
                            intIndex++;
                            strToken = "";
                        }
                        if (chrNext == "=")
                        {
                            arrTokens.Add(chrChar + "=");
                            intIndex++;
                            intCntr++;
                        }
                        else
                        {
                            arrTokens.Add(chrChar);
                            intIndex++;
                        }
                        break;
                    case "=":
                        if (strToken.Length > 0)
                        {
                            arrTokens.Add(strToken);
                            intIndex++;
                            strToken = "";
                        }
                        arrTokens.Add(chrChar);
                        intIndex++;
                        break;
                    case "'":
                        if (strToken.Length > 0)
                        {
                            arrTokens.Add(strToken);
                            intIndex++;
                            strToken = "";
                        }

                        intPos = pstrExpression.IndexOf(chrChar, intCntr + 1);
                        if (intPos < 0)
                            throw new Exception("Unterminated string constant");
                        else
                        {
                            strToken += pstrExpression.Substring(intCntr + 1, intPos);
                            arrTokens.Add(strToken);
                            intIndex++;
                            strToken = "";
                            intCntr = intPos;
                        }
                        break;
                    case "\"":
                        if (strToken.Length > 0)
                        {
                            arrTokens.Add(strToken);
                            intIndex++;
                            strToken = "";
                        }

                        intPos = pstrExpression.IndexOf(chrChar, intCntr + 1);
                        if (intPos < 0)
                        {
                            throw new Exception("Unterminated string constant");
                        }
                        else
                        {
                            strToken += pstrExpression.Substring(intCntr + 1, intPos);
                            arrTokens.Add(strToken);
                            intIndex++;
                            strToken = "";
                            intCntr = intPos;
                        }
                        break;
                    default:
                        strToken += chrChar;
                        break;
                }
                intCntr++;
            }
            if (intBraces > 0)
                throw new Exception("Unbalanced parenthesis!");

            if (strToken.Length > 0)
                arrTokens.Add(strToken);

            return arrTokens.ToArray();
        }

        private string GetVariable(string strVarName)
        {

            if (arrVars == null)
                throw new Exception("Variable values are not supplied!");

            if (!arrVars.ContainsKey(strVarName))
                throw new Exception("Variable [" + strVarName + "] not defined");

            return arrVars[strVarName];
        }

        /*------------------------------------------------------------------------------
        * NAME       : InFixToPostFix
        * PURPOSE    : Convert an Infix expression into a postfix (RPN) equivalent
        * PARAMETERS : Infix expression element array
        * RETURNS    : array containing postfix expression element tokens
        *----------------------------------------------------------------------------*/
        private string[] InFixToPostFix(string[] arrToks)
        {
            Stack myStack = new Stack();
            int intCntr, intIndex = 0;
            string strTok, strTop, strNext, strPrev;
            bool blnStart = false;
            List<string> arrPFix = new List<string>();

            // Infix to postfix converter
            for (intCntr = 0; intCntr < arrToks.Length; intCntr++)
            {
                strTok = arrToks[intCntr];
                switch (strTok)
                {
                    case "(":
                        if (myStack.Count > 0 && IsFunction(myStack.Peek().ToString()))
                        {
                            arrPFix.Add(ARG_TERMINAL);
                            intIndex++;
                        }
                        myStack.Push(strTok);
                        break;
                    case ")":
                        blnStart = true;
                        while (!(myStack.Count == 0))
                        {
                            strTok = myStack.Pop().ToString();
                            if (strTok != "(")
                            {
                                arrPFix.Add(strTok);
                                intIndex++;
                            }
                            else
                            {
                                blnStart = false;
                                break;
                            }
                        }
                        if (myStack.Count == 0 && blnStart)
                            throw new Exception("Unbalanced parenthesis!");
                        break;
                    case ",":
                        if (myStack.Count == 0) break;
                        while (!(myStack.Count == 0))
                        {
                            strTok = myStack.Peek().ToString();
                            if (strTok == "(") break;
                            arrPFix.Add(myStack.Pop().ToString());
                            intIndex++;
                        }
                        break;
                    case "!":
                    case "-":
                    case "^":
                    case "*":
                    case "/":
                    case "%":
                    case "+":
                    case "&":
                    case "|":
                    case ">":
                    case "<":
                    case "=":
                    case ">=":
                    case "<=":
                    case "<>":
                        // check for unary negative operator.
                        if (strTok == "-")
                        {
                            strPrev = null;
                            if (intCntr > 0)
                                strPrev = arrToks[intCntr - 1];
                            strNext = arrToks[intCntr + 1];
                            if (strPrev == null || IsOperator(strPrev) || strPrev == "(")
                            {
                                strTok = UNARY_NEG;
                            }
                        }

                        // check for unary + addition operator, we need to ignore this.
                        if (strTok == "+")
                        {
                            strPrev = null;
                            if (intCntr > 0)
                                strPrev = arrToks[intCntr - 1];
                            strNext = arrToks[intCntr + 1];
                            if (strPrev == null || IsOperator(strPrev) || strPrev == "(")
                            {
                                break;
                            }
                        }

                        strTop = "";
                        if (!(myStack.Count == 0)) strTop = myStack.Peek().ToString();
                        if (myStack.Count == 0 || (!(myStack.Count == 0) && strTop == "("))
                        {
                            myStack.Push(strTok);
                        }
                        else if (Precedence(strTok) > Precedence(strTop))
                        {
                            myStack.Push(strTok);
                        }
                        else
                        {
                            // Pop operators with precedence >= operator strTok
                            while (!(myStack.Count == 0))
                            {
                                strTop = myStack.Peek().ToString();
                                if (strTop == "(" || Precedence(strTop) < Precedence(strTok))
                                {
                                    break;
                                }
                                else
                                {
                                    arrPFix.Add(myStack.Pop().ToString());
                                    intIndex++;
                                }
                            }
                            myStack.Push(strTok);
                        }
                        break;
                    default:
                        if (!IsFunction(strTok))
                        {
                            // Token is an operand
                            if (IsNumber(strTok))
                                strTok = ToNumber(strTok);
                            else if (IsBoolean(strTok))
                                strTok = ToBoolean(strTok);
                            else if (IsDate(strTok))
                                strTok = ToDate(strTok, dtFormat);

                            arrPFix.Add(strTok);
                            intIndex++;
                            break;
                        }
                        else
                        {
                            strTop = "";
                            if (!(myStack.Count == 0)) strTop = myStack.Peek().ToString();
                            if (myStack.Count == 0 || (!(myStack.Count == 0) && strTop == "("))
                            {
                                myStack.Push(strTok);
                            }
                            else if (Precedence(strTok) > Precedence(strTop))
                            {
                                myStack.Push(strTok);
                            }
                            else
                            {
                                // Pop operators with precedence >= operator in strTok
                                while (!(myStack.Count == 0))
                                {
                                    strTop = myStack.Peek().ToString();
                                    if (strTop == "(" || Precedence(strTop) < Precedence(strTok))
                                    {
                                        break;
                                    }
                                    else
                                    {
                                        arrPFix.Add(myStack.Pop().ToString());
                                        intIndex++;
                                    }
                                }
                                myStack.Push(strTok);
                            }
                        }
                        break;
                }
            }

            // Pop remaining operators from stack.
            while (!(myStack.Count == 0))
            {
                arrPFix.Add(myStack.Pop().ToString());
                intIndex++;
            }
            return arrPFix.ToArray();
        }

        /*------------------------------------------------------------------------------
        * NAME       : HandleFunctions
        * PURPOSE    : Execute built-in functions
        * PARAMETERS : pstrTok - The current function name
        *              pStack - Operand stack
        * RETURNS    : Nothing, the result is pushed back onto the stack.
        *----------------------------------------------------------------------------*/
        private void HandleFunctions(string pstrTok, ref Stack pStack, string pdtFormat, Dictionary<string, string> parrVars)
        {
            string varTmp, varTerm, objTmp;
            string objOp1, objOp2;
            string[] arrArgs;
            int intCntr;

            if (!IsFunction(pstrTok))
                throw new Exception("Unsupported function token [" + pstrTok + "]");

            varTmp = pstrTok.ToUpper();
            arrArgs = new string[2000];
            while (!(pStack.Count == 0))
            {
                varTerm = ARG_TERMINAL;
                varTerm = pStack.Pop().ToString();
                if (varTerm != ARG_TERMINAL)
                    arrArgs[arrArgs.Length] = varTerm;
                else
                    break;
            }

            switch (varTmp)
            {
                case "DATE":
                    varTerm = DateTime.Now.ToString(pdtFormat);
                    pStack.Push(varTerm);
                    break;
                case "ACOS":
                case "ASIN":
                case "ATAN":
                    throw new Exception("Function [" + varTmp + "] is not implemented!");
                case "ABS":
                case "CHR":
                case "COS":
                case "FIX":
                case "HEX":
                case "LOG":
                case "ROUND":
                case "SIN":
                case "SQRT":
                case "TAN":
                    if (arrArgs.Length < 1)
                        throw new Exception(varTmp + " requires atleast one argument!");
                    else if (arrArgs.Length > 1)
                        throw new Exception(varTmp + " requires only one argument!");
                    varTerm = arrArgs[0];
                    if (IsVariable(varTerm))
                    {
                        if (!parrVars.ContainsKey(varTerm))
                            throw new Exception("Variable [" + varTerm + "] not defined");
                        objTmp = parrVars[varTerm];
                        varTerm = objTmp;
                    }
                    if (!IsNumber(varTerm))
                        throw new Exception(varTmp + " operates on numeric operands only!");
                    else
                    {
                        objTmp = ToNumber(varTerm);
                        if (varTmp == "ABS")
                            pStack.Push(Math.Abs(double.Parse(objTmp)));
                        else if (varTmp == "CHR")
                            pStack.Push(Convert.ToChar(objTmp));
                        else if (varTmp == "COS")
                            pStack.Push(Math.Cos(double.Parse(objTmp)));
                        else if (varTmp == "FIX")
                            pStack.Push(Math.Floor(double.Parse(objTmp)));
                        else if (varTmp == "HEX")
                            pStack.Push(double.Parse(objTmp).ToString("X"));
                        else if (varTmp == "LOG")
                            pStack.Push(Math.Log(double.Parse(objTmp)));
                        else if (varTmp == "ROUND")
                            pStack.Push(Math.Round(double.Parse(objTmp)));
                        else if (varTmp == "SIN")
                            pStack.Push(Math.Sin(double.Parse(objTmp)));
                        else if (varTmp == "SQRT")
                            pStack.Push(Math.Sqrt(double.Parse(objTmp)));
                        else if (varTmp == "TAN")
                            pStack.Push(Math.Tan(double.Parse(objTmp)));
                    }
                    break;
                case "ASC":
                    if (arrArgs.Length > 1)
                        throw new Exception(varTmp + " requires only one argument!");
                    else if (arrArgs.Length < 1)
                        throw new Exception(varTmp + " requires atleast one argument!");
                    varTerm = arrArgs[0];
                    if (IsVariable(varTerm))
                    {
                        if (!parrVars.ContainsKey(varTerm))
                            throw new Exception("Variable [" + varTerm + "] not defined");

                        objTmp = parrVars[varTerm];
                        varTerm = objTmp;
                    }
                    if (IsNumber(varTerm) || IsBoolean(varTerm) || IsDate(varTerm))
                        throw new Exception(varTmp + " requires a string type operand!");
                    else
                        pStack.Push(Convert.ToInt16(varTerm));
                    break;
                case "LCASE":
                case "UCASE":
                case "CDATE":
                    if (arrArgs.Length < 1)
                        throw new Exception(varTmp + " requires atleast one argument!");
                    else if (arrArgs.Length > 1)
                        throw new Exception(varTmp + " requires only one argument!");

                    varTerm = arrArgs[0];
                    if (IsVariable(varTerm))
                    {
                        if (!parrVars.ContainsKey(varTerm))
                            throw new Exception("Variable [" + varTerm + "] not defined");

                        objTmp = parrVars[varTerm];
                        varTerm = objTmp;
                    }

                    if (varTmp == "CDATE" && !IsDate(varTerm))
                        throw new Exception("CDate can not convert [" + varTerm + "] to a valid date!");
                    else if (IsNumber(varTerm) || IsBoolean(varTerm))
                        throw new Exception(varTmp + " requires a string type operand!");
                    else
                    {
                        if (varTmp == "LCASE")
                            pStack.Push(varTerm.ToLower());
                        else if (varTmp == "UCASE")
                            pStack.Push(varTerm.ToUpper());
                        else if (varTmp == "CDATE")
                        {
                            objTmp = ToDate(varTerm, pdtFormat);
                            pStack.Push(DateTime.Parse(objTmp));
                        }
                    }
                    break;
                case "LEFT":
                case "RIGHT":
                    if (arrArgs.Length < 2)
                        throw new Exception(varTmp + " requires atleast two arguments!");
                    else if (arrArgs.Length > 2)
                        throw new Exception(varTmp + " requires only two arguments!");

                    for (intCntr = 0; intCntr < arrArgs.Length; intCntr++)
                    {
                        varTerm = arrArgs[intCntr];
                        if (IsVariable(varTerm))
                        {
                            if (!parrVars.ContainsKey(varTerm))
                                throw new Exception("Variable [" + varTerm + "] not defined");

                            objTmp = parrVars[varTerm];
                            varTerm = objTmp;
                        }
                        if (intCntr == 0 && !IsNumber(varTerm))
                            throw new Exception(varTmp + " oprator requires numaric length!");
                        arrArgs[intCntr] = varTerm;
                    }
                    varTerm = arrArgs[1];
                    objTmp = ToNumber(arrArgs[0]);
                    if (varTmp == "LEFT")
                        pStack.Push(varTerm.Substring(0, int.Parse(objTmp)));
                    else
                        pStack.Push(varTerm.Substring((varTerm.Length - int.Parse(objTmp)), int.Parse(objTmp)));
                    break;
                case "MID":
                case "IIF":
                    if (arrArgs.Length < 3)
                        throw new Exception(varTmp + " requires atleast three arguments!");
                    else if (arrArgs.Length > 3)
                        throw new Exception(varTmp + " requires only three arguments!");

                    for (intCntr = 0; intCntr < arrArgs.Length; intCntr++)
                    {
                        varTerm = arrArgs[intCntr];
                        if (IsVariable(varTerm))
                        {
                            if (!parrVars.ContainsKey(varTerm))
                                throw new Exception("Variable [" + varTerm + "] not defined");

                            objTmp = parrVars[varTerm];
                            varTerm = objTmp;
                        }
                        if (varTerm == "MID" && intCntr <= 1 && !IsNumber(varTerm))
                            throw new Exception(varTmp + " oprator requires numaric lengths!");
                        else if (varTerm == "IIF" && intCntr == 2 && !IsBoolean(varTerm))
                            throw new Exception(varTmp + " oprator requires boolean condition!");
                        arrArgs[intCntr] = varTerm;
                    }
                    if (varTmp == "MID")
                    {
                        varTerm = arrArgs[2];
                        objOp1 = ToNumber(arrArgs[1]);
                        objOp2 = ToNumber(arrArgs[0]);
                        pStack.Push(varTerm.Substring(int.Parse(objOp1), int.Parse(objOp2)));
                    }
                    else
                    {
                        varTerm = ToBoolean(arrArgs[2]);
                        objOp1 = arrArgs[1];
                        objOp2 = arrArgs[0];
                        if (bool.Parse(varTerm))
                            pStack.Push(objOp1);
                        else
                            pStack.Push(objOp2);
                    }
                    break;

                case "AVG":
                case "MAX":
                case "MIN":
                    if (arrArgs.Length < 2)
                        throw new Exception(varTmp + " requires atleast two operands!");

                    objTmp = "0";
                    for (intCntr = 0; intCntr < arrArgs.Length; intCntr++)
                    {
                        varTerm = arrArgs[intCntr];
                        if (IsVariable(varTerm))
                        {
                            if (!parrVars.ContainsKey(varTerm))
                                throw new Exception("Variable [" + varTerm + "] not defined");

                            objTmp = parrVars[varTerm];
                            varTerm = objTmp;
                        }
                        if (!IsNumber(varTerm))
                            throw new Exception(varTmp + " requires numaric operands only!");

                        varTerm = ToNumber(varTerm);
                        if (varTmp == "AVG")
                            objTmp = (double.Parse(objTmp) + double.Parse(varTerm)).ToString();
                        else if (varTmp == "MAX" && double.Parse(objTmp) < double.Parse(varTerm))
                            objTmp = varTerm;
                        else if (varTmp == "MIN")
                        {
                            if (intCntr == 1)
                                objTmp = varTerm;
                            else if (double.Parse(objTmp) > double.Parse(varTerm))
                                objTmp = varTerm;
                        }
                    }
                    if (varTmp == "AVG")
                        pStack.Push(double.Parse(objTmp) / arrArgs.Length);
                    else
                        pStack.Push(objTmp);
                    break;

                case "INT":
                    if (arrArgs.Length > 1)
                        throw new Exception(varTmp + " only with a parameter!");
                    pStack.Push((int)(double.Parse(arrArgs[0])));
                    break;
            }
        }

        /*------------------------------------------------------------------------------
        * NAME       : IsNumber
        * PURPOSE    : Checks whether the specified parameter is a number.
        * RETURNS    : True - If supplied parameter can be succesfully converted to a number
        *              False - Otherwise
        *----------------------------------------------------------------------------*/
        private bool IsNumber(string pstrVal)
        {
            long l;
            if (long.TryParse(pstrVal, out l))
            {
                return true;
            }

            double d;
            if (double.TryParse(pstrVal, out d))
            {
                return true;
            }

            return false;
        }

        /*------------------------------------------------------------------------------
        * NAME       : IsBoolean
        * PURPOSE    : Checks whether the specified parameter is a boolean value.
        * PARAMETERS : pstrVal - The string to be checked.
        * RETURNS    : True - If supplied parameter is a boolean constant
        *              False - Otherwise
        *----------------------------------------------------------------------------*/
        private bool IsBoolean(string pstrVal)
        {
            bool b;
            if (bool.TryParse(pstrVal, out b))
                return true;
            return false;
        }

        /*------------------------------------------------------------------------------
        * NAME       : ToNumber
        * PURPOSE    : Converts the supplied parameter to numaric type.
        * PARAMETERS : pobjVal - The string to be converted to equvalent number.
        * RETURNS    : numaric value if string represents a number
        * THROWS     : Exception if string can not be converted 
        *----------------------------------------------------------------------------*/
        private string ToNumber(string pobjVal)
        {
            long l;
            if (long.TryParse(pobjVal, out l))
            {
                return l.ToString();
            }

            double d;
            if (double.TryParse(pobjVal, out d))
            {
                return d.ToString();
            }

            return null;
        }

        /*------------------------------------------------------------------------------
        * NAME       : ToBoolean
        * PURPOSE    : Converts the supplied parameter to boolean value
        * PARAMETERS : pobjVal - The parameter to be converted.
        * RETURNS    : Boolean value
        *----------------------------------------------------------------------------*/
        private string ToBoolean(string pobjVal)
        {
            bool b;
            if (bool.TryParse(pobjVal, out b))
                return b.ToString();
            return null;
        }

        /*------------------------------------------------------------------------------
        * NAME       : Precedence
        * PURPOSE    : Returns the precedence of a given operator
        * PARAMETERS : pstrTok - The operator token whose precedence is to be returned.
        * RETURNS    : Integer
        *----------------------------------------------------------------------------*/
        private int Precedence(string pstrTok)
        {
            var intRet = 0;

            switch (pstrTok)
            {
                case "+":
                case "-":
                    intRet = 5;
                    break;
                case "*":
                case "/":
                case "%":
                    intRet = 6;
                    break;
                case "^":
                    intRet = 7;
                    break;
                case UNARY_NEG:
                case "!":
                    intRet = 10;
                    break;
                case "(":
                    intRet = 99;
                    break;
                case "&":
                case "|":
                    intRet = 3;
                    break;
                case ">":
                case ">=":
                case "<":
                case "<=":
                case "=":
                case "<>":
                    intRet = 4;
                    break;
                default:
                    if (IsFunction(pstrTok))
                        intRet = 9;
                    else
                        intRet = 0;
                    break;
            }
            return intRet;
        }

        /*------------------------------------------------------------------------------
        * NAME       : IsDigit
        * PURPOSE    : Checks whether the character specified by chrArg is a numeric 
        *              character.
        * PARAMETERS : chrArg - The character to be checked
        * RETURNS    : False - If chrArg is not a numeric character
        *              True - Otherwise 
        *----------------------------------------------------------------------------*/
        private bool IsDigit(string chrArg)
        {
            if (lstDigits.IndexOf(chrArg) >= 0)
                return true;
            return false;
        }

        /*------------------------------------------------------------------------------
        * NAME       : IsAlpha
        * PURPOSE    : Checks whether the character specified by chrArg is a alphabet 
        * PARAMETERS : chrArg - The character to be checked
        * RETURNS    : False - If chrArg is not a alphabet
        *              True - Otherwise 
        *----------------------------------------------------------------------------*/
        private bool IsAlpha(string chrArg)
        {
            if (lstAlpha.IndexOf(chrArg) >= 0 ||
                lstAlpha.ToUpper().IndexOf(chrArg) >= 0)
                return true;
            return false;
        }

        /*------------------------------------------------------------------------------
        * NAME       : IsOperator
        * PURPOSE    : Checks whether the string specified by strArg is an operator
        * PARAMETERS : strArg - The string to be checked
        * RETURNS    : False - If strArg is not an operator symbol
        *              True - Otherwise 
        *----------------------------------------------------------------------------*/
        private bool IsOperator(string strArg)
        {
            if (lstArithOps.IndexOf(strArg) >= 0 || lstCompaOps.IndexOf(strArg) >= 0)
                return true;
            return false;
        }

        /*------------------------------------------------------------------------------
        * NAME       : IsFunction
        * PURPOSE    : Checks whether the string specified by strArg is a function name
        * PARAMETERS : strArg - The string to be checked
        * RETURNS    : False - If strArg is not a valid built-in function name.
        *              True - Otherwise 
        *----------------------------------------------------------------------------*/
        private bool IsFunction(string strArg)
        {
            int idx = 0;

            strArg = strArg.ToUpper();
            for (idx = 0; idx < lstFuncOps.Length; idx++)
            {
                if (strArg == lstFuncOps[idx])
                    return true;
            }
            return false;
        }

        /// <summary>
        /// 判断是否日期
        /// </summary>
        /// <param name="pstrVal"></param>
        /// <returns></returns>
        private bool IsDate(string pstrVal)
        {
            DateTime d;
            if (DateTime.TryParse(pstrVal, out d))
                return true;
            return false;
        }

        /// <summary>
        /// 转换成日期字符串
        /// </summary>
        /// <param name="pobjVal"></param>
        /// <param name="strFormat"></param>
        /// <returns></returns>
        private string ToDate(string pobjVal, string strFormat)
        {
            DateTime d;
            if (DateTime.TryParse(pobjVal, out d))
                return d.ToString(strFormat);
            return null;
        }

        /*------------------------------------------------------------------------------
        * NAME       : IsVariable
        * PURPOSE    : Checks whether the specified parameter is a user defined variable.
        * RETURNS    : True - If supplied parameter identifies a user defined variable
        *              False - Otherwise 
        *----------------------------------------------------------------------------*/
        private bool IsVariable(string pstrVal)
        {
            if (lstArithOps.IndexOf(pstrVal) >= 0 ||
                lstLogicOps.IndexOf(pstrVal) >= 0 ||
                lstCompaOps.IndexOf(pstrVal) >= 0 ||
                IsBoolean(pstrVal) ||
                IsDate(pstrVal) ||
                IsNumber(pstrVal) ||
                IsFunction(pstrVal))
                return false;
            return true;
        }
    }
}