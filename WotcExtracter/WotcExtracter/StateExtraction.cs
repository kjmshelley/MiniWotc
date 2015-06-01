using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Linq;
using System.IO;
using WotcExtracter.Data;
using System.Data;

namespace WotcExtracter
{
    public class StateExtraction : Extraction
    {
        public StateExtraction(string fileName)
            : base(fileName)
        {
        }

        public override bool Extract(IDataSource s)
        {
            DBDataSource source = (DBDataSource)s;
            if (string.IsNullOrEmpty(FileName))
                throw new Exception("File name is not specificed.");
            if (!System.IO.File.Exists(FileName))
                throw new Exception("Extract file does not exist");

            XElement ep = XElement.Load(FileName);
            var ds = from d in ep.Elements("datasource") select d;
            if (ds == null || ds.Count() < 1 || ds.Elements("connection") == null ||
                ds.Elements("state_parameter") == null || ds.Elements("from_date_parameter") == null ||
                ds.Elements("to_date_parameter") == null)
                throw new Exception("Could not find datasource in Extract file");

            source.Open(ds.Elements("connection").ToList()[0].Value);
            source.AddParameter("@state", ds.Elements("state_parameter").ToList()[0].Value);
            source.AddParameter("@from", ds.Elements("from_date_parameter").ToList()[0].Value);
            source.AddParameter("@to", ds.Elements("to_date_parameter").ToList()[0].Value);

            //remember all datasources will return a datatable 
            DataTable table = source.Read(ds.Elements("source").ToList()[0].Value);

            var columns = from cols in ep.Elements("export").Elements("file").Elements("column")
                          select cols;
            if (columns == null)
                throw new Exception("Extract file is not in the correct format");

            StringBuilder builder = new StringBuilder();
            foreach (DataRow row in table.Rows)
            {
                foreach (var c in columns)
                {
                    string value = string.Empty,
                        format = string.Empty, formatType = string.Empty;
                    /* if there is a default value then we will not look to the 
                     * datasource to provide a value 
                     * */
                    if (c.Element("default_value") != null)
                    {
                        value = c.Element("default_value").Value;
                    }
                    else
                    {
                        value = (c.Element("name") != null) ? c.Element("name").Value : string.Empty;
                        value = row[value].ToString();
                    }
                    if (c.Element("conditional_format") != null)
                    {
                        value = ConditionalFormatting(c.Element("conditional_format"), value);
                    }

                    format = (c.Element("format") != null) ? c.Element("format").Value : string.Empty;
                    formatType = (c.Element("format_type") != null) ? c.Element("format_type").Value : string.Empty;
                    value = FormatValue(value, format, formatType);
                    builder.Append(value);
                    if (c.Element("delimiter") != null)
                        builder.Append(c.Element("delimiter").Value);
                }
                builder.Append(Environment.NewLine);
            }

            var file = from f in ep.Elements("export")
                       select f;
            if (file == null || file.Elements("file_name") == null)
                throw new Exception("Export file name is not in the export file");

            FileDataSource fds = new FileDataSource(file.Elements("file_name").ToList()[0].Value);
            fds.Write(builder.ToString());

            source.Close();
            return true;
        }
    }
}
