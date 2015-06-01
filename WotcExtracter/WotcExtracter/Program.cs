using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using WotcExtracter.Data;

namespace WotcExtracter
{
    /// <summary>
    /// This is a very basic file extract program. There is a base class Extraction 
    /// that will take a datasource, transform the data and export it to a file format.
    /// If you would like to add custom extract code for a specific use case, you can
    /// just inherit from the base class. For example, one implementation for this 
    /// extract program is for sending Electronic data to the states. Each state 
    /// typically has a data dictionary and they are unique from each other. 
    /// So there is a base class, StateExtraction, that inherits from the top base class
    /// Extraction. Any and all states can use this base class, StateExtraction if it is a 
    /// simple data dump. However, if the data structure is complex, you can inherit from 
    /// StateExtraction and override the main method Extract.
    /// 
    /// All extracts run on a batch job. The batch job will call this program .exe and 
    /// send the needed arguments for the respective job. The params are:
    /// [ExtractType] [ExtractLocation] [DataType]
    /// 
    /// ExtractType is kind of like a project. For example, since if you want to have exports 
    /// for a particular client, i.e. Walmart, you can have a ExtractType call Walmart. You will
    /// need to add it to the below ExtractType. And proceed to create a class that inherits from
    /// the base class. 
    /// 
    /// ExtractLocation is the location of the extract settings and format. 
    /// 
    /// DataType is the type of datasource the data will come from, i.e. Database, Flat File, etc.
    /// </summary>
    class Program
    {
        static void Main(string[] args)
        {
            int extractType = 0,  extractionLocation = 1, dataSource = 2;
            if (args.Length == 0 || args.Length < 2)
            {
                Console.WriteLine("Missing Arguments");
                Console.ReadKey();
                return;
            }

            Extraction e = GetExtraction(args[extractType], args[extractionLocation]);
            IDataSource ds = GetDataSource(args[dataSource]);
            e.Extract(ds);
            Console.ReadKey();
        }

        private static Extraction GetExtraction(string extractType, string extractLocation)
        {
            switch (extractType)
            {
                case "STATE":
                    return new StateExtraction(extractLocation);
                default:
                    return new DefaultExtraction(extractLocation);
            }
        }

        private static IDataSource GetDataSource(string dataSource)
        {
            switch (dataSource)
            {
                case "DB":
                    return new DBDataSource();
                case "FLAT_FILE":
                    return new FileDataSource();
                case "XML":
                    return new XmlDataSource();
                case "EXCEL":
                    return new ExcelDataSource();
                case "WEB":
                    return new WebDataSource();
                default:
                    return new DefaultDataSource();
            }
        }
    }
}
