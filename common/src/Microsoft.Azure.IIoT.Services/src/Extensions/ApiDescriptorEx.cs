// ------------------------------------------------------------
//  Copyright (c) Microsoft Corporation.  All rights reserved.
//  Licensed under the MIT License (MIT). See License.txt in the repo root for license information.
// ------------------------------------------------------------

namespace Swashbuckle.AspNetCore.Swagger {
    using Microsoft.AspNetCore.Authorization;
    using Microsoft.AspNetCore.Authorization.Infrastructure;
    using Microsoft.AspNetCore.Mvc.Controllers;
    using Microsoft.AspNetCore.Mvc.Infrastructure;
    using Microsoft.Extensions.DependencyInjection;
    using Microsoft.Extensions.Options;
    using System.Collections.Generic;
    using System.Linq;
    using System.Security.Claims;

    /// <summary>
    /// Api descriptor extensions
    /// </summary>
    public static class ApiDescriptorEx {

        /// <summary>
        /// Collect configured scopes from all controllers registered as services
        /// </summary>
        /// <param name="services"></param>
        /// <returns></returns>
        public static IEnumerable<string> GetRequiredScopes(
            this IServiceCollection services) {
            var provider = services.BuildServiceProvider();
            var options = provider.GetRequiredService<IOptions<AuthorizationOptions>>();
            return provider.GetRequiredService<IActionDescriptorCollectionProvider>()
                .ActionDescriptors.Items
                .OfType<ControllerActionDescriptor>()
                .Cast<ControllerActionDescriptor>()
                .SelectMany(d => d.GetRequiredPolicyGlaims(options.Value))
                .Distinct();
        }

        /// <summary>
        /// Retrieve claims from descriptor
        /// </summary>
        /// <param name="descriptor"></param>
        /// <param name="options"></param>
        /// <returns></returns>
        public static IEnumerable<string> GetRequiredPolicyGlaims(
            this ControllerActionDescriptor descriptor, AuthorizationOptions options) {
            var attributes = descriptor.GetAttributes<AuthorizeAttribute>(false);
            var requirements = attributes
                .Select(attr => attr.Policy)
                .Select(options.GetPolicy)
                .SelectMany(x => x.Requirements)
                .Distinct();
            var claims = requirements.OfType<ClaimsAuthorizationRequirement>()
                .Select(x => x.ClaimType);
            var roles = requirements.OfType<RolesAuthorizationRequirement>()
                .SelectMany(x => x.AllowedRoles)
                .Concat(attributes.Where(a => a.Roles != null).Select(a => a.Roles));
            if (roles.Any()) {
                claims = claims.Append(ClaimTypes.Role);
            }
            if (requirements.OfType<DenyAnonymousAuthorizationRequirement>().Any()) {
                claims = claims.Append(ClaimTypes.Authentication);
            }
            return claims.Distinct();
        }

        /// <summary>
        /// Rerturn controller and action attributes sorted
        /// </summary>
        /// <param name="descriptor"></param>
        /// <param name="inherit"></param>
        /// <returns></returns>
        public static IEnumerable<T> GetAttributes<T>(
            this ControllerActionDescriptor descriptor, bool inherit) {
            var controllerAttributes = descriptor.ControllerTypeInfo
                .GetCustomAttributes(inherit);
            var actionAttributes = descriptor.MethodInfo
                .GetCustomAttributes(inherit);
            return controllerAttributes
                .Append(actionAttributes)
                .OfType<T>();
        }
    }
}
