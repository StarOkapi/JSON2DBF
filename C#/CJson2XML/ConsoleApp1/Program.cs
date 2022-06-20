using System;
using System.IO;
using System.Xml.Linq;
using Newtonsoft.Json;

namespace ConvertJson2XML
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Convert");

                    //string json = @"{  'VFPData': {    'cfgsys': [      {        'cfs_id': 1,        'cfs_des': 'Config. de ABM',        'cfs_valor': 2,        'cfs_valor2': 0,        'cfs_obs': '0 - No trare Registros\n1 - Trae todo los registros\n2 - Automatico el sistema determina si trae o no todos los registros',        'cfs_marca': true      },      {        'cfs_id': 2,        'cfs_des': 'Cantidad de Registros',        'cfs_valor': 200000,        'cfs_valor2': 0,        'cfs_obs': 'Cantidad de registros limites (Depende del parametro 1, si esta configurado en 2)',        'cfs_marca': false      },      {        'cfs_id': 3,        'cfs_des': 'ODBC',        'cfs_valor': 0,        'cfs_valor2': 'SQL2000',        'cfs_obs': '',        'cfs_marca': true      },      {        'cfs_id': 4,        'cfs_des': 'Base de Datos',        'cfs_valor': 0,        'cfs_valor2': 'cp_lc',        'cfs_obs': '',        'cfs_marca': true      },      {        'cfs_id': 5,        'cfs_des': 'String de Conexion',        'cfs_valor': 0,        'cfs_valor2': 0,        'cfs_obs': 'Driver={SQL Native Client};Server=notebookcyp\\sqlexpress;Database=cp_lc;Uid=sa;Pwd=!sql2005;',        'cfs_marca': true      },      {        'cfs_id': 6,        'cfs_des': 'Traer Cursores',        'cfs_valor': 1,        'cfs_valor2': 0,        'cfs_obs': 'Traer valor de los cursores cuando presiona todos',        'cfs_marca': true      },      {        'cfs_id': 7,        'cfs_des': 'Server DB',        'cfs_valor': 0,        'cfs_valor2': '(local)',        'cfs_obs': '',        'cfs_marca': false      },      {        'cfs_id': 8,        'cfs_des': 'Seguridad',        'cfs_valor': 1,        'cfs_valor2': 0,        'cfs_obs': '1-Nivel SA\n2-Nivel Usuarios Integrado con SQL',        'cfs_marca': false      }    ]  }}";
                string json="";
                string fileName = @"file.json";

                using (
                
                
                StreamReader streamReader = File.OpenText(fileName))
                {
                         json = streamReader.ReadToEnd();
                        //Console.WriteLine(text);
                    }

                XNode node = JsonConvert.DeserializeXNode(json, "VFPData");

                    Console.WriteLine(node.ToString());

                    //File.WriteAllLines("copnfig.xml",node.ToString());

                    File.WriteAllText("Tmpfile.xml", "<?xml version = '1.0' encoding = 'UTF-8' standalone = 'yes' ?>" + node.ToString());
        }
    }
}
