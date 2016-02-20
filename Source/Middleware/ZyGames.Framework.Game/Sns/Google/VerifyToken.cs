﻿using System;

using System.Web;
using System.Web.SessionState;
using System.Web.Routing;

using System.Security.Claims;
using System.Security.Cryptography;
using System.Security.Cryptography.X509Certificates;

using System.IdentityModel.Tokens;
using System.IdentityModel.Selectors;


using System.Net;
using System.IO;
using System.Collections.Generic;
using System.Threading.Tasks;
using System.Linq;
using System.Text;

using Google.Apis.Oauth2.v2;
using Google.Apis.Oauth2.v2.Data;
using Google.Apis.Util;
using Newtonsoft.Json;







//namespace rolaweb.Script.Sns
namespace ZyGames.Framework.Game.Sns.Google
{
    /// <summary>
    ///  This is a minimal implementation of OAuth V2 verification that
    ///  demonstrates:
    ///    - ID Token validation
    ///    - Access token validation
    /// </summary>
    /// @author class@google.com (Gus Class)
    public class VerifyToken
    {
        // Get this from your app at https://code.google.com/apis/console
        static public string CLIENT_ID = "984767616471";

        // Values returned in the response
        private access_token_status ats = new access_token_status();

        private id_token_status its = new id_token_status();

        /// <summary>
        /// Processes the request based on the path.
        /// </summary>
        /// <param name="context">Contains the request and response.</param>
        public void ProcessRequest(string accessToken, string idToken)
        {
            // Get the code from the request POST body.
            //string accessToken = context.Request.Params["access_token"];
            //string idToken = context.Request.Params["id_token"];

            // Validate the ID token
            if (idToken != null)
            {
                JwtSecurityToken token = new JwtSecurityToken(idToken);
                JwtSecurityTokenHandler jsth = new JwtSecurityTokenHandler();

                // Configure validation
                Byte[][] certBytes = getCertBytes();
                Dictionary<String, X509Certificate2> certificates = new Dictionary<String, X509Certificate2>();

                for (int i = 0; i < certBytes.Length; i++)
                {
                    X509Certificate2 certificate = new X509Certificate2(certBytes[i]);
                    certificates.Add(certificate.Thumbprint, certificate);
                }
                {
                    // Set up token validation
                    TokenValidationParameters tvp = new TokenValidationParameters()
                    {
                        ValidateActor = false, // check the profile ID

                        ValidateAudience = (CLIENT_ID != "984767616471"), // check the client ID
                        ValidAudience = CLIENT_ID,

                        ValidateIssuer = true, // check token came from Google
                        ValidIssuer = "https://accounts.google.com",

                        ValidateIssuerSigningKey = true,
                        RequireSignedTokens = true,
                        CertificateValidator = X509CertificateValidator.None,
                        IssuerSigningKeyResolver = (s, securityToken, identifier, parameters) =>
                        {
                            return identifier.Select(x =>
                            {
                                // TODO: Consider returning null here if you have case sensitive JWTs.
                                /*if (!certificates.ContainsKey(x.Id))
                                {
                                    return new X509SecurityKey(certificates[x.Id]);
                                }*/
                                if (certificates.ContainsKey(x.Id.ToUpper()))
                                {
                                    return new X509SecurityKey(certificates[x.Id.ToUpper()]);
                                }
                                return null;
                            }).First(x => x != null);
                        },
                        ValidateLifetime = true,
                        RequireExpirationTime = true,
                        ClockSkew = TimeSpan.FromHours(13)
                    };

                    try
                    {
                        // Validate using the provider
                        SecurityToken validatedToken;
                        ClaimsPrincipal cp = jsth.ValidateToken(idToken, tvp, out validatedToken);
                        if (cp != null)
                        {
                            its.valid = true;
                            its.message = "Valid ID Token.";
                        }
                    }
                    catch (Exception e)
                    {
                        // Multiple certificates are tested.
                        if (its.valid != true)
                        {
                            its.message = "Invalid ID Token.";
                        }
                        if (e.Message.IndexOf("The token is expired") > 0)
                        {
                            // TODO: Check current time in the exception for clock skew.
                        }
                    }
                }

                // Get the Google+ id for this user from the "sub" claim.
                Claim[] claims = token.Claims.ToArray<Claim>();
                for (int i = 0; i < claims.Length; i++)
                {
                    if (claims[i].Type.Equals("sub"))
                    {
                        its.gplus_id = claims[i].Value;
                    }
                }
            }

            // Use Tokeninfo to validate the user and the client.
            var tokeninfo_request = new Oauth2Service().Tokeninfo();
            tokeninfo_request.AccessToken = accessToken;

            // Use Google as a trusted provider to validate the token.
            // Invalid values, including expired tokens, return 400
            Tokeninfo tokeninfo = null;
            try
            {
                tokeninfo = tokeninfo_request.Execute();
                if (tokeninfo.IssuedTo != CLIENT_ID)
                {
                    ats.message = "Access Token not meant for this app.";
                }
                else
                {
                    ats.valid = true;
                    ats.message = "Valid Access Token.";
                    ats.gplus_id = tokeninfo.UserId;
                }
            }
            catch (Exception stve)
            {
                ats.message = "Invalid Access Token: " + stve.Message;
            }

            // Use the wrapper to return JSON
            result = new token_status_wrapper();
            result.id_token_status = its;
            result.access_token_status = ats;

            //context.Response.StatusCode = 200;
            //context.Response.ContentType = "text/json";
            //context.Response.Write(JsonConvert.SerializeObject(tsr));
        }

        // Used for string parsing the Certificates from Google
        private const string beginCert = "-----BEGIN CERTIFICATE-----\\n";

        private const string endCert = "\\n-----END CERTIFICATE-----\\n";

        /// <summary>
        /// Retrieves the certificates for Google and returns them as byte arrays.
        /// </summary>
        /// <returns>An array of byte arrays representing the Google certificates.</returns>
        public byte[][] getCertBytes()
        {
            // The request will be made to the authentication server.
            WebRequest request = WebRequest.Create(
                "https://www.googleapis.com/oauth2/v1/certs"
            );

            StreamReader reader = new StreamReader(request.GetResponse().GetResponseStream());

            string responseFromServer = reader.ReadToEnd();

            String[] split = responseFromServer.Split(':');

            // There are two certificates returned from Google
            byte[][] certBytes = new byte[2][];
            int index = 0;
            UTF8Encoding utf8 = new UTF8Encoding();
            for (int i = 0; i < split.Length; i++)
            {
                if (split[i].IndexOf(beginCert) > 0)
                {
                    int startSub = split[i].IndexOf(beginCert);
                    int endSub = split[i].IndexOf(endCert) + endCert.Length;
                    certBytes[index] = utf8.GetBytes(split[i].Substring(startSub, endSub).Replace("\\n", "\n"));
                    index++;
                }
            }
            return certBytes;
        }

        /// <summary>
        /// Stores the result data for the ID token verification.
        /// </summary>
        public class id_token_status
        {
            public Boolean valid = false;
            public String gplus_id = null;
            public String message = "";
        }

        /// <summary>
        /// Stores the result data for the access token verification.
        /// </summary>
        public class access_token_status
        {
            public Boolean valid = false;
            public String gplus_id = null;
            public String message = "";
        }

        /// <summary>
        /// Stores the result data for both token status responses.
        /// </summary>
        public class token_status_wrapper
        {
            public id_token_status id_token_status = null;
            public access_token_status access_token_status = null;
        }


        public token_status_wrapper result = null;


        //public bool IsReusable { get { return false; } }
    }
}
