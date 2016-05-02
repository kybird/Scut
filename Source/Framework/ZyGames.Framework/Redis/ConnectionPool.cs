using ServiceStack.Net30.Collections.Concurrent;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ZyGames.Framework.Common;

namespace ZyGames.Framework.Redis
{
    public static class ConnectionPool
    {
        public const string EntityKeyPreChar = "$";
        internal const string EntityKeySplit = "_";
        private static string RedisInfoKey = "__RedisInfo";

        
        private static ConcurrentDictionary<string, ObjectPoolWithExpire<RedisClientCluster>> _poolCache;


        static ConnectionPool()
        {
            _poolCache = new ConcurrentDictionary<string, ObjectPoolWithExpire<RedisClientCluster>>();

        }



       


       
        



        


    }
}
