#pragma checksum "C:\SemesterProj (1)\Facebook\Views\Profile\Index.cshtml" "{ff1816ec-aa5e-4d10-87f7-6f4963833460}" "300aa946bed0a623b674172c9f7646bc33db6f18"
// <auto-generated/>
#pragma warning disable 1591
[assembly: global::Microsoft.AspNetCore.Razor.Hosting.RazorCompiledItemAttribute(typeof(AspNetCore.Views_Profile_Index), @"mvc.1.0.view", @"/Views/Profile/Index.cshtml")]
namespace AspNetCore
{
    #line hidden
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Threading.Tasks;
    using Microsoft.AspNetCore.Mvc;
    using Microsoft.AspNetCore.Mvc.Rendering;
    using Microsoft.AspNetCore.Mvc.ViewFeatures;
#nullable restore
#line 1 "C:\SemesterProj (1)\Facebook\Views\_ViewImports.cshtml"
using Facebook;

#line default
#line hidden
#nullable disable
#nullable restore
#line 1 "C:\SemesterProj (1)\Facebook\Views\Profile\Index.cshtml"
using Facebook.Models;

#line default
#line hidden
#nullable disable
#nullable restore
#line 2 "C:\SemesterProj (1)\Facebook\Views\Profile\Index.cshtml"
using Newtonsoft.Json;

#line default
#line hidden
#nullable disable
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"SHA1", @"300aa946bed0a623b674172c9f7646bc33db6f18", @"/Views/Profile/Index.cshtml")]
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"SHA1", @"85a14a5177546289a23389ae5e0bbe53c37af8ba", @"/Views/_ViewImports.cshtml")]
    #nullable restore
    public class Views_Profile_Index : global::Microsoft.AspNetCore.Mvc.Razor.RazorPage<dynamic>
    #nullable disable
    {
        private static readonly global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute __tagHelperAttribute_0 = new global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute("class", new global::Microsoft.AspNetCore.Html.HtmlString("card-img-top img-setting"), global::Microsoft.AspNetCore.Razor.TagHelpers.HtmlAttributeValueStyle.DoubleQuotes);
        private static readonly global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute __tagHelperAttribute_1 = new global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute("src", new global::Microsoft.AspNetCore.Html.HtmlString("~/icons/download.png"), global::Microsoft.AspNetCore.Razor.TagHelpers.HtmlAttributeValueStyle.DoubleQuotes);
        private static readonly global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute __tagHelperAttribute_2 = new global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute("alt", new global::Microsoft.AspNetCore.Html.HtmlString("Card image cap"), global::Microsoft.AspNetCore.Razor.TagHelpers.HtmlAttributeValueStyle.DoubleQuotes);
        #line hidden
        #pragma warning disable 0649
        private global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperExecutionContext __tagHelperExecutionContext;
        #pragma warning restore 0649
        private global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperRunner __tagHelperRunner = new global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperRunner();
        #pragma warning disable 0169
        private string __tagHelperStringValueBuffer;
        #pragma warning restore 0169
        private global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperScopeManager __backed__tagHelperScopeManager = null;
        private global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperScopeManager __tagHelperScopeManager
        {
            get
            {
                if (__backed__tagHelperScopeManager == null)
                {
                    __backed__tagHelperScopeManager = new global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperScopeManager(StartTagHelperWritingScope, EndTagHelperWritingScope);
                }
                return __backed__tagHelperScopeManager;
            }
        }
        private global::Microsoft.AspNetCore.Mvc.Razor.TagHelpers.UrlResolutionTagHelper __Microsoft_AspNetCore_Mvc_Razor_TagHelpers_UrlResolutionTagHelper;
        #pragma warning disable 1998
        public async override global::System.Threading.Tasks.Task ExecuteAsync()
        {
#nullable restore
#line 3 "C:\SemesterProj (1)\Facebook\Views\Profile\Index.cshtml"
  
    ViewData["Title"] = "Profile";

#line default
#line hidden
#nullable disable
            WriteLiteral(@"<style>
    .card-style {
        width: 100%;
        margin: 0 auto;
    }

    .img-setting {
        width: 150px !important;
        height: 150px;
        margin: 0 auto;
    }

    .section {
        height: 58px;
        width: 100%;
        background-color: #195cb3;
    }

    .lead {
        font-size: 3.25rem;
        font-weight: 300;
    }

    .custom-icon {
        color: gray;
    }
</style>
");
#nullable restore
#line 33 "C:\SemesterProj (1)\Facebook\Views\Profile\Index.cshtml"
  
    var sessionUser = new Byte[20];
    bool user = Context.Session.TryGetValue("User", out sessionUser);
    UserLogin users = new UserLogin();
    if (user)
    {
        users = JsonConvert.DeserializeObject<UserLogin>(System.Text.Encoding.UTF8.GetString(sessionUser));

    }

#line default
#line hidden
#nullable disable
            WriteLiteral("<div class=\"container text-center\">\r\n\r\n    <div class=\"card card-style\"");
            BeginWriteAttribute("style", " style=\"", 898, "\"", 906, 0);
            EndWriteAttribute();
            WriteLiteral(">\r\n        ");
            __tagHelperExecutionContext = __tagHelperScopeManager.Begin("img", global::Microsoft.AspNetCore.Razor.TagHelpers.TagMode.StartTagOnly, "300aa946bed0a623b674172c9f7646bc33db6f185608", async() => {
            }
            );
            __Microsoft_AspNetCore_Mvc_Razor_TagHelpers_UrlResolutionTagHelper = CreateTagHelper<global::Microsoft.AspNetCore.Mvc.Razor.TagHelpers.UrlResolutionTagHelper>();
            __tagHelperExecutionContext.Add(__Microsoft_AspNetCore_Mvc_Razor_TagHelpers_UrlResolutionTagHelper);
            __tagHelperExecutionContext.AddHtmlAttribute(__tagHelperAttribute_0);
            __tagHelperExecutionContext.AddHtmlAttribute(__tagHelperAttribute_1);
            __tagHelperExecutionContext.AddHtmlAttribute(__tagHelperAttribute_2);
            await __tagHelperRunner.RunAsync(__tagHelperExecutionContext);
            if (!__tagHelperExecutionContext.Output.IsContentModified)
            {
                await __tagHelperExecutionContext.SetOutputContentAsync();
            }
            Write(__tagHelperExecutionContext.Output);
            __tagHelperExecutionContext = __tagHelperScopeManager.End();
            WriteLiteral("\r\n        <p class=\"lead\">\r\n            ");
#nullable restore
#line 48 "C:\SemesterProj (1)\Facebook\Views\Profile\Index.cshtml"
       Write(users.Username.ToUpper());

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n        </p>\r\n        <p>\r\n            <a href=\"#\"> ");
#nullable restore
#line 51 "C:\SemesterProj (1)\Facebook\Views\Profile\Index.cshtml"
                    Write(users.Email);

#line default
#line hidden
#nullable disable
            WriteLiteral(@"</a>
        </p>
        <div class=""card-body"">
            <div class=""text-left"">

                <h3>Intro</h3>
                <br />
                <div class=""pl-3"" style=""background:#e8e2e2"">
                    <b>Add Bio</b>
                </div>
                <br/>
                <!--Home Icon-->
                <div class=""pl-4 d-flex justify-content-between w-25"">

                    <div>
                        <i class=""fas fa-home custom-icon""></i>

                    </div>
                    <div>
                        <p class=""pr-3"">Lives in <b>Karachi, Pakistan</b></p>
                    </div>
                </div>
                <!--Location Icon-->
                <div class=""pl-4 d-flex justify-content-between w-25"">

                    <div>
                        <i class=""fas fa-map-marker custom-icon""></i>

                    </div>
                    <div>
                        <p");
            BeginWriteAttribute("class", " class=\"", 2110, "\"", 2118, 0);
            EndWriteAttribute();
            WriteLiteral(@" style=""padding-right:2rem"">From <b>Karachi, Pakistan</b></p>
                    </div>
                </div>
                <!--martial Icon-->
                <div class=""pl-4 d-flex justify-content-between "" style=""width:10%"">

                    <div>
                        <i class=""fas fa-heart custom-icon""></i>
                    </div>
                    <div>
                        <p><b>Single</b></p>
                    </div>
                </div>
            </div>
            
        </div>
    </div>


</div>");
        }
        #pragma warning restore 1998
        #nullable restore
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.ViewFeatures.IModelExpressionProvider ModelExpressionProvider { get; private set; } = default!;
        #nullable disable
        #nullable restore
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.IUrlHelper Url { get; private set; } = default!;
        #nullable disable
        #nullable restore
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.IViewComponentHelper Component { get; private set; } = default!;
        #nullable disable
        #nullable restore
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.Rendering.IJsonHelper Json { get; private set; } = default!;
        #nullable disable
        #nullable restore
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.Rendering.IHtmlHelper<dynamic> Html { get; private set; } = default!;
        #nullable disable
    }
}
#pragma warning restore 1591
