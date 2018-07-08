using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FGA_MODEL.Production
{
    class FGA_PartTransfer_HModel
    {
        public int RecordCnt { get; set; }
        public int Indexs { get; set; }
        public string ShipperNO { get; set; }
        public string Organization { get; set; }
        public string FromLoc { get; set; }
        public string ToLoc { get; set; }
        public string Creator { get; set; }
        public DateTime CreateDate { get; set; }
        public string Receiver { get; set; }
        public DateTime ReceptionDate { get; set; }
    }
}
