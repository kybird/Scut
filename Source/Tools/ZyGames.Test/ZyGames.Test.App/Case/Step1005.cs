/****************************************************************************
Copyright (c) 2013-2015 scutgame.com

http://www.scutgame.com

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
****************************************************************************/

using System;
using ZyGames.Framework.RPC.IO;

namespace ZyGames.Test.App.Case
{
    /// <summary>
    /// 创角
    /// </summary>
    public class Step1005 : CaseStep
    {
        protected override void SetUrlElement()
        {
            SetRequestParam("Type", (short)1);
            SetRequestParam("RoleName", "Role" + _session.Context.UserId);
            SetRequestParam("Appearance", "DEPRECATED");
            SetRequestParam("Eye", (int)1);
            SetRequestParam("FaceType", (int)1);
            SetRequestParam("Skin", (int)1);
            SetRequestParam("HairStyle", (int)1);

        }

        protected override bool DecodePacket(MessageStructure reader, MessageHead head)
        {
            short type = reader.ReadShort();
            long roleID = reader.ReadLong();
            string roleName = reader.ReadString();
            string appearance = reader.ReadString();
            DateTime createDate = reader.ReadDateTime();

            _session.Context.RoleID = roleID;


            SetChildStep("1008"); // 로그인으로!


            return true;
        }

    }
}