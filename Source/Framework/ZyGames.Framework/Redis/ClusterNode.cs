using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ZyGames.Framework.Redis
{
    public class ClusterNode
    {
        public string ip;
        public ushort port;

        public ulong epoch;
        public ulong ping;
        public ulong pong;

        public ushort startSlot;
        public ushort endSlot;

        public string masterUUID;

        private string UUID;
        private bool master;
        private bool connected;

        private HashSet<ClusterNode> slaves;

    }


}
