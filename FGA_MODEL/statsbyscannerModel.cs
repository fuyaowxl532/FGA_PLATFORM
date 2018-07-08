using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FGA_MODEL
{
    public class statsbyscannerModel
    {
        public string  SerialNO { get; set; }
        public string  PartNO { get; set; }
        public string  PartName { get; set; }
        public string  Location { get; set; }
        public decimal Quantity { get; set; }
        public decimal ActualQuantity { get; set; }
        public string AreaCode { get; set; }
        public string  Def1 { get; set; }
        public string  Def2 { get; set; }

        public string Creater { get; set; }
        public DateTime Createtime { get; set; }
    }

}
