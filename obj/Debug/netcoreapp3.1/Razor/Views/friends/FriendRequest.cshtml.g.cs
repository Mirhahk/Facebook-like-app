#pragma checksum "C:\SemesterProj (1)\Facebook\Views\friends\FriendRequest.cshtml" "{ff1816ec-aa5e-4d10-87f7-6f4963833460}" "b2c69cf88669c5da37b2b101eda45fbdb230b88b"
// <auto-generated/>
#pragma warning disable 1591
[assembly: global::Microsoft.AspNetCore.Razor.Hosting.RazorCompiledItemAttribute(typeof(AspNetCore.Views_friends_FriendRequest), @"mvc.1.0.view", @"/Views/friends/FriendRequest.cshtml")]
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
#line 5 "C:\SemesterProj (1)\Facebook\Views\friends\FriendRequest.cshtml"
using Facebook.Models;

#line default
#line hidden
#nullable disable
#nullable restore
#line 6 "C:\SemesterProj (1)\Facebook\Views\friends\FriendRequest.cshtml"
using Newtonsoft.Json;

#line default
#line hidden
#nullable disable
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"SHA1", @"b2c69cf88669c5da37b2b101eda45fbdb230b88b", @"/Views/friends/FriendRequest.cshtml")]
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"SHA1", @"85a14a5177546289a23389ae5e0bbe53c37af8ba", @"/Views/_ViewImports.cshtml")]
    #nullable restore
    public class Views_friends_FriendRequest : global::Microsoft.AspNetCore.Mvc.Razor.RazorPage<Facebook.Models.UserLogin>
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
#line 1 "C:\SemesterProj (1)\Facebook\Views\friends\FriendRequest.cshtml"
  
	ViewData["Title"] = "Friend Request";

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n");
#nullable restore
#line 7 "C:\SemesterProj (1)\Facebook\Views\friends\FriendRequest.cshtml"
  
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

<div class=""container text-center"">

	<div class=""card card-style""");
            BeginWriteAttribute("style", " style=\"", 587, "\"", 595, 0);
            EndWriteAttribute();
            WriteLiteral(">\r\n\t\t");
            __tagHelperExecutionContext = __tagHelperScopeManager.Begin("img", global::Microsoft.AspNetCore.Razor.TagHelpers.TagMode.StartTagOnly, "b2c69cf88669c5da37b2b101eda45fbdb230b88b5345", async() => {
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
            WriteLiteral("\r\n\t\t<p class=\"lead\">\r\n\t\t\t");
#nullable restore
#line 44 "C:\SemesterProj (1)\Facebook\Views\friends\FriendRequest.cshtml"
       Write(Model.Username.ToUpper());

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n\t\t</p>\r\n\t\t<p>\r\n\t\t\t<a href=\"#\"> ");
#nullable restore
#line 47 "C:\SemesterProj (1)\Facebook\Views\friends\FriendRequest.cshtml"
                    Write(Model.Email);

#line default
#line hidden
#nullable disable
            WriteLiteral(@"</a>
		</p>
		<div>
			<button class=""btn btn-success"" id=""btnFriendReq"">Accept Friend Request</button>
		</div>
		<div class=""card-body"">
			<div class=""text-left"">

				<h3>Intro</h3>
				<br />
				<div class=""pl-3"" style=""background:#e8e2e2"">
					<b>Add Bio</b>
				</div>
				<br />
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
            BeginWriteAttribute("class", " class=\"", 1529, "\"", 1537, 0);
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


</div>
<!--Storing FriendId-->
<input type=""hidden""");
            BeginWriteAttribute("value", " value=\"", 1954, "\"", 1985, 1);
#nullable restore
#line 101 "C:\SemesterProj (1)\Facebook\Views\friends\FriendRequest.cshtml"
WriteAttributeValue("", 1962, Model.UserFriend_pk_id, 1962, 23, false);

#line default
#line hidden
#nullable disable
            EndWriteAttribute();
            WriteLiteral(" id=\"hiddenFriendId\" />\r\n<script>\r\n\t$(\"#btnFriendReq\").click(function () {\r\n\t\tlet friendId = $(\"#hiddenFriendId\").val();\r\n\t\t$.ajax({\r\n\t\t\turl: \"");
#nullable restore
#line 106 "C:\SemesterProj (1)\Facebook\Views\friends\FriendRequest.cshtml"
             Write(Url.Action("HandleFriendReqFinal","Friends"));

#line default
#line hidden
#nullable disable
            WriteLiteral("\",\r\n\t\t\ttype: \"GET\",\r\n\t\t\tdata: { id: friendId },\r\n\t\t\tsuccess: function (res) {\r\n\t\t\t\tif(res){\r\n\t\t\t\t\t$.notify(\"Friend Request Accepted\", \"success\");\r\n\t\t\t\t}\r\n\r\n\t\t\t}\r\n\r\n\t\t});\r\n\r\n\t});\r\n</script>");
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
        public global::Microsoft.AspNetCore.Mvc.Rendering.IHtmlHelper<Facebook.Models.UserLogin> Html { get; private set; } = default!;
        #nullable disable
    }
}
#pragma warning restore 1591
