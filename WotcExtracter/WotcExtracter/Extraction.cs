using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Linq;
using System.IO;
using WotcExtracter.Data;
using System.Data;
using System.Collections;

namespace WotcExtracter
{
    public abstract class Extraction
    {
        protected string FileName { get; set; }
        public Extraction(string fileName)
        {
            FileName = fileName;
        }

        public virtual bool Extract(IDataSource source)
        {
            if (string.IsNullOrEmpty(FileName))
                throw new Exception("File name is not specificed.");
            if (!System.IO.File.Exists(FileName))
                throw new Exception("Extract file does not exist");

            XElement ep = XElement.Load(FileName);
            var ds = from d in ep.Elements("datasource") select d;
            if (ds == null || ds.Count() < 1 || ds.Elements("connection").Count() < 1)
                throw new Exception("Could not find datasource in Extract file");

            source.Open(ds.Elements("connection").ToList()[0].Value);
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

            return true;
        }

        /// <summary>
        /// The below method offers a better approach(I feel). Because you 
        /// can add more complex formats and you can test and throw exceptions 
        /// on formats
        /// </summary>
        /// <param name="name"></param>
        /// <param name="format"></param>
        /// <param name="formatType"></param>
        protected virtual string FormatValue(string value, string format, string formatType)
        {
            string tempValue = value;
            if (formatType == "date")
            {
                DateTime dt = DateTime.Now;
                if (!DateTime.TryParse(tempValue, out dt))
                    return tempValue;
                tempValue = dt.ToString(format);
            }
            else if (formatType == "number")
            {
                double d = 0.0;
                if (!Double.TryParse(tempValue, out d))
                    return tempValue;
                tempValue = d.ToString(format);
            }
            return tempValue;
        }

        protected virtual string ConditionalFormatting(XElement conditions, string value)
        {
            //if no condition matches, return the original value
            string tempValue = value;
            foreach (var condition in conditions.Elements("values").Elements())
            {
                if (value == condition.Element("input").Value)
                    tempValue = condition.Element("output").Value;
            }
            return tempValue;
        }
    }
}
