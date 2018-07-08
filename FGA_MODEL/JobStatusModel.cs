using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FGA_MODEL
{
    public class JobStatusModel
    {
        public string JobNO { get; set; }
        public string JobKey { get; set; }
        public string PartNO { get; set; }
        public string PartName { get; set; }
        public string PartGroup { get; set; }
        public string JobStatus { get; set; }
        public string Note { get; set; }
        public string Creater { get; set; }
        public DateTime CreateDate { get; set; }
    }

}
