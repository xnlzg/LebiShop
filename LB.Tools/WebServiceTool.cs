using System;
using System.Collections.Generic;
using System.Text;
using System.Xml;
using System.Net;
using System.Web.Services.Description;
using System.CodeDom;
using System.CodeDom.Compiler;
using System.Reflection;
using System.IO;
using Microsoft.CSharp;
namespace LB.Tools
{
    /// <summary>
    /// ���������
    /// </summary>
    public sealed class WebServiceTool
    {

        private WebServiceTool() { }

        public static object InvokeWebService(string url, string methodname, object[] args)
        {
            return WebServiceTool.InvokeWebService(url, null, methodname, args, "");
        }

        public static object InvokeWebService(string url, string classname, string methodname, object[] args, string import)
        {
            string @namespace = "EnterpriseServerBase.WebService.DynamicWebCalling";
            if ((classname == null) || (classname == ""))
            {
                classname = WebServiceTool.GetWsClassName(url);
            }

            //try
            //{

            //��ȡWSDL  
            WebClient wc = new WebClient();
            ServiceDescriptionImporter sdi = new ServiceDescriptionImporter();

            if (!url.ToLower().Contains("?wsdl"))
                url = url + "?wsdl";
            Stream stream = wc.OpenRead(url);
            ServiceDescription sd = ServiceDescription.Read(stream);
            sdi.AddServiceDescription(sd, "", "");

            if (import != "")
            {
                string[] urls = import.Split(',');
                foreach (string addr in urls)
                {
                    string u = addr;
                    if (!addr.ToLower().Contains("?wsdl"))
                        u = addr + "?wsdl";
                    stream = wc.OpenRead(u);
                    sd = ServiceDescription.Read(stream);
                    sdi.AddServiceDescription(sd, "", "");
                }
            }
            CodeNamespace cn = new CodeNamespace(@namespace);

            //���ɿͻ��˴��������  
            CodeCompileUnit ccu = new CodeCompileUnit();
            ccu.Namespaces.Add(cn);
            sdi.Import(cn, ccu);
            CSharpCodeProvider icc = new CSharpCodeProvider();
            //ICodeCompiler icc = csc.CreateCompiler();

            //�趨�������  
            CompilerParameters cplist = new CompilerParameters();
            cplist.GenerateExecutable = false;
            cplist.GenerateInMemory = true;
            cplist.ReferencedAssemblies.Add("System.dll");
            cplist.ReferencedAssemblies.Add("System.XML.dll");
            cplist.ReferencedAssemblies.Add("System.Web.Services.dll");
            cplist.ReferencedAssemblies.Add("System.Data.dll");

            //���������  
            CompilerResults cr = icc.CompileAssemblyFromDom(cplist, ccu);
            if (true == cr.Errors.HasErrors)
            {
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                foreach (System.CodeDom.Compiler.CompilerError ce in cr.Errors)
                {
                    sb.Append(ce.ToString());
                    sb.Append(System.Environment.NewLine);
                }
                throw new Exception(sb.ToString());
            }

            //���ɴ���ʵ���������÷���  
            System.Reflection.Assembly assembly = cr.CompiledAssembly;
            string sb1 = "";
            foreach (var t1 in assembly.GetTypes())
            {
                sb1 += t1.Name + "    || ";
            }
            //throw new Exception(sb1);
            //return null;
            Type t = assembly.GetType(@namespace + "." + classname, true, true);
            object obj = Activator.CreateInstance(t);
            System.Reflection.MethodInfo mi = t.GetMethod(methodname);

            return mi.Invoke(obj, args);
            //}
            //catch (Exception ex)
            //{
            //    throw new Exception(ex.InnerException.Message, new Exception(ex.InnerException.StackTrace));
            //}
        }

        private static string GetWsClassName(string wsUrl)
        {
            string[] parts = wsUrl.Split('/');
            string[] pps = parts[parts.Length - 1].Split('.');

            return pps[0];
        }

    }
}
