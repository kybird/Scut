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
using System.Collections.Generic;
using ZyGames.Framework.Common;
using ZyGames.Framework.Common.Log;
using ZyGames.Framework.RPC.IO;

namespace ZyGames.Test.App.Case
{
    /// <summary>
    /// 登录
    /// </summary>
    public class Step1004 : CaseStep
    {
        protected override void SetUrlElement()
        {
            //_session.Context.PassportId = "Z" + (_session.Setting.PassprotId + _session.Id);
            //string pwd = EncodePassword(_session.Setting.UserPwd);
            SetRequestParam("MobileType", 1);
            SetRequestParam("Token", _session.Context.Token);
            SetRequestParam("IMEI", _session.Id);
            SetRequestParam("RetailID", "1234");
            SetRequestParam("Pid", _session.Context.PassportId);
            SetRequestParam("Pwd", _session.Context.Password);
            SetRequestParam("ScreenX", "500");
            SetRequestParam("ScreenY", "400");
            SetRequestParam("ClientAppVersion", "1");

            
            
            //writer.writeString("IMEI", actionParam.Get<String>("IMEI"));
            //writer.writeString("RetailID", actionParam.Get<String>("RetailID"));
            //writer.writeString("Pid", "1");
            //writer.writeString("Pwd", "1");
            //writer.writeInt32("ScreenX", actionParam.Get<Int32>("ScreenX"));
            //writer.writeInt32("ScreenY", actionParam.Get<Int32>("ScreenY"));
            //writer.writeString("ClientAppVersion", actionParam.Get<String>("ClientAppVersion"));

        }

        protected override bool DecodePacket(MessageStructure reader, MessageHead head)
        {
            string sessionID = reader.ReadString();
            string userId = reader.ReadString();
            int UserType = reader.ReadInt();
            short count = reader.ReadShort();

            int subRecordCount = reader.ReadInt();

            var subTable = new Dictionary<string, object>();
            for (int i = 0; i < subRecordCount; i++)
            {
                var subRecord = new Dictionary<string, object>();
                reader.RecordStart();
                subRecord["ClothSetSlotID"] = reader.ReadShort();
                subRecord["Lv"] = reader.ReadUInt16().ToString();
                subRecord["Type"] = reader.ReadUInt16();
                subRecord["RoleId"] = reader.ReadUInt64();
                subRecord["RoleName"] = reader.ReadString();
                subRecord["Appearance"] = reader.ReadString();
                subRecord["CreateDate"] = reader.ReadDateTime();
                _session.Context.RoleID = subRecord["RoleId"].ToLong();

                reader.RecordEnd();
            }

            int premiumMoney = reader.ReadInt();
            _session.Context.SessionId = sessionID;
            TraceLog.WriteInfo("UserID:{0}", userId);


            if (subRecordCount == 0)
            {
                SetChildStep("1005"); // 케릭터 생성
            }
            else
            {
                SetChildStep("1008"); // 월드인
            }
            return true;
        }

    }
}