﻿//------------------------------------------------------------------------------
// <auto-generated>
//     此代码由工具生成。
//     运行时版本:4.0.30319.34014
//
//     对此文件的更改可能会导致不正确的行为，并且如果
//     重新生成代码，这些更改将会丢失。
// </auto-generated>
//------------------------------------------------------------------------------

namespace InnoSoft.LS.Resources {
    using System;
    
    
    /// <summary>
    ///   一个强类型的资源类，用于查找本地化的字符串等。
    /// </summary>
    // 此类是由 StronglyTypedResourceBuilder
    // 类通过类似于 ResGen 或 Visual Studio 的工具自动生成的。
    // 若要添加或移除成员，请编辑 .ResX 文件，然后重新运行 ResGen
    // (以 /str 作为命令选项)，或重新生成 VS 项目。
    [global::System.CodeDom.Compiler.GeneratedCodeAttribute("System.Resources.Tools.StronglyTypedResourceBuilder", "4.0.0.0")]
    [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
    [global::System.Runtime.CompilerServices.CompilerGeneratedAttribute()]
    public class ToolTips {
        
        private static global::System.Resources.ResourceManager resourceMan;
        
        private static global::System.Globalization.CultureInfo resourceCulture;
        
        [global::System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1811:AvoidUncalledPrivateCode")]
        internal ToolTips() {
        }
        
        /// <summary>
        ///   返回此类使用的缓存的 ResourceManager 实例。
        /// </summary>
        [global::System.ComponentModel.EditorBrowsableAttribute(global::System.ComponentModel.EditorBrowsableState.Advanced)]
        public static global::System.Resources.ResourceManager ResourceManager {
            get {
                if (object.ReferenceEquals(resourceMan, null)) {
                    global::System.Resources.ResourceManager temp = new global::System.Resources.ResourceManager("InnoSoft.LS.Resources.ToolTips", typeof(ToolTips).Assembly);
                    resourceMan = temp;
                }
                return resourceMan;
            }
        }
        
        /// <summary>
        ///   使用此强类型资源类，为所有资源查找
        ///   重写当前线程的 CurrentUICulture 属性。
        /// </summary>
        [global::System.ComponentModel.EditorBrowsableAttribute(global::System.ComponentModel.EditorBrowsableState.Advanced)]
        public static global::System.Globalization.CultureInfo Culture {
            get {
                return resourceCulture;
            }
            set {
                resourceCulture = value;
            }
        }
        
        /// <summary>
        ///   查找类似 点击换一张 的本地化字符串。
        /// </summary>
        public static string ClicktoChangeIndentifyCode {
            get {
                return ResourceManager.GetString("ClicktoChangeIndentifyCode", resourceCulture);
            }
        }
        
        /// <summary>
        ///   查找类似 结算公式用于计算客户结算价格，由算数、算符和括号组成。其中：&lt;br/&gt;1、算数可以为常数（如1.03和94等）和变量（如公里数、吨数、垛数和单价4种）。&lt;br/&gt;2、算符可以是“+”、“－”、“*”和“/”4种。&lt;br/&gt;&lt;br/&gt;示例：&lt;br/&gt;1、吨数*单价&lt;br/&gt;2、0.5229*公里数*吨数&lt;br/&gt;3、0.5139*公里数*吨数*0.94-10&lt;br/&gt;4、垛数*单价 的本地化字符串。
        /// </summary>
        public static string SettlementExpression {
            get {
                return ResourceManager.GetString("SettlementExpression", resourceCulture);
            }
        }
        
        /// <summary>
        ///   查找类似 运费公式用于计算承运单位承运价格，它由算数、算符和括号组成。其中：&lt;br/&gt;1、算数可以为常数（如1.03和94等）、变量（如公里数、吨数、垛数和单价4种）和函数（如取整数函数INT等）。&lt;br/&gt;2、算符可以是“+”、“－”、“*”和“/”4种。&lt;br/&gt;&lt;br/&gt;示例：&lt;br/&gt;1、吨数*单价&lt;br/&gt;2、0.5229*公里数*吨数&lt;br/&gt;3、0.5139*公里数*吨数*0.94-10&lt;br/&gt;4、垛数*单价&lt;br/&gt;5、INT(公里数*吨数*单价) 的本地化字符串。
        /// </summary>
        public static string TransportChargeExpression {
            get {
                return ResourceManager.GetString("TransportChargeExpression", resourceCulture);
            }
        }
        
        /// <summary>
        ///   查找类似 单价公式用于根据承运单位承运价格倒推出单价，它由算数、算符和括号组成。其中：&lt;br/&gt;1、算数可以为常数（如1.03和94等）和变量（如公里数、吨数、垛数和运费4种）。&lt;br/&gt;2、算符可以是“+”、“－”、“*”和“/”4种。&lt;br/&gt;&lt;br/&gt;示例：&lt;br/&gt;1、运费/吨数&lt;br/&gt;2、运费/(0.5229*公里数*吨数)&lt;br/&gt;3、(运费+10)/(0.5139*公里数*吨数*0.94)&lt;br/&gt;4、运费/垛数 的本地化字符串。
        /// </summary>
        public static string TransportPriceExpression {
            get {
                return ResourceManager.GetString("TransportPriceExpression", resourceCulture);
            }
        }
    }
}
