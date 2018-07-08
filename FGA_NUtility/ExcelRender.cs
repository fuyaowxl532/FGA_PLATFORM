using System.Data;
using System.IO;
using System.Text;
using System.Web;
using NPOI.HSSF.UserModel;
using NPOI.SS.UserModel;
using System;
using NPOI.HSSF.Util;
using NPOI.SS.Util;
using System.Collections.Generic;
using NPOI.XSSF.UserModel;
using NPOI.XSSF.Util;

/// <summary>
/// 使用NPOI操作Excel，无需Office COM组件
/// Created By 囧月 http://lwme.cnblogs.com
/// 部分代码取自http://msdn.microsoft.com/zh-tw/ee818993.aspx
/// NPOI是POI的.NET移植版本，目前稳定版本中仅支持对xls文件（Excel 97-2003）文件格式的读写
/// NPOI官方网站http://npoi.codeplex.com/
/// </summary>
public class ExcelRender
{
    /// <summary>
    /// 根据Excel列类型获取列的值
    /// </summary>
    /// <param name="cell">Excel列</param>
    /// <returns></returns>
    private static string GetCellValue(ICell cell)
    {
        if (cell == null)
            return string.Empty;
        switch (cell.CellType)
        {
            case CellType.Blank:
                return string.Empty;
            case CellType.Boolean:
                return cell.BooleanCellValue.ToString();
            case CellType.Error:
                return cell.ErrorCellValue.ToString();
            case CellType.Numeric:
            case CellType.Unknown:
            default:
                return cell.ToString();//This is a trick to get the correct value of the cell. NumericCellValue will return a numeric value no matter the cell value is a date or a number
            case CellType.String:
                return cell.StringCellValue;
            case CellType.Formula:
                try
                {
                    HSSFFormulaEvaluator e = new HSSFFormulaEvaluator(cell.Sheet.Workbook);
                    e.EvaluateInCell(cell);
                    return cell.ToString();
                }
                catch
                {
                    return cell.NumericCellValue.ToString();
                } 
        }
    }

    /// <summary>
    /// 自动设置Excel列宽
    /// </summary>
    /// <param name="sheet">Excel表</param>
    private static void AutoSizeColumns(ISheet sheet)
    {
        if (sheet.PhysicalNumberOfRows > 0)
        {
            IRow headerRow = sheet.GetRow(0);

            for (int i = 0, l = headerRow.LastCellNum; i < l; i++)
            {
                sheet.AutoSizeColumn(i);
            }
        }
    }

    /// <summary>
    /// 保存Excel文档流到文件
    /// </summary>
    /// <param name="ms">Excel文档流</param>
    /// <param name="fileName">文件名</param>
    private static bool SaveToFile(MemoryStream ms, string fileName)
    {
        try
        {
            using (FileStream fs = new FileStream(fileName, FileMode.Create, FileAccess.Write))
            {
                byte[] data = ms.ToArray();

                fs.Write(data, 0, data.Length);
                fs.Flush();

                data = null;
                return true;
            }
        }
        catch(Exception)
        {
            return false;
        }
    }

    /// <summary>
    /// 输出文件到浏览器
    /// </summary>
    /// <param name="ms">Excel文档流</param>
    /// <param name="context">HTTP上下文</param>
    /// <param name="fileName">文件名</param>
    private static void RenderToBrowser(MemoryStream ms, HttpContext context, string fileName)
    {
        if (context.Request.Browser.Browser == "IE")
            fileName = HttpUtility.UrlEncode(fileName);
        context.Response.AddHeader("Content-Disposition", "attachment;fileName=" + fileName);
        context.Response.BinaryWrite(ms.ToArray());
    }

    /// <summary>
    /// DataReader转换成Excel文档流
    /// </summary>
    /// <param name="reader"></param>
    /// <returns></returns>
    public static MemoryStream RenderToExcel(IDataReader reader)
    {
        MemoryStream ms = new MemoryStream();

        using (reader)
        {
           // using (IWorkbook workbook = new HSSFWorkbook())
           // {
                //using (ISheet sheet = workbook.CreateSheet())
               // {
            IWorkbook workbook = new HSSFWorkbook();
            ISheet sheet = workbook.CreateSheet();
                    IRow headerRow = sheet.CreateRow(0);
                    int cellCount = reader.FieldCount;

                    // handling header.
                    for (int i = 0; i < cellCount; i++)
                    {
                        headerRow.CreateCell(i).SetCellValue(reader.GetName(i));
                    }

                    // handling value.
                    int rowIndex = 1;
                    while (reader.Read())
                    {
                        IRow dataRow = sheet.CreateRow(rowIndex);

                        for (int i = 0; i < cellCount; i++)
                        {
                            dataRow.CreateCell(i).SetCellValue(reader[i].ToString());
                        }

                        rowIndex++;
                    }
                    AutoSizeColumns(sheet);

                    workbook.Write(ms);
                    ms.Flush();
                    ms.Position = 0;
                }
          //  }
        //}
        return ms;
    }

    /// <summary>
    /// DataReader转换成Excel文档流，并保存到文件
    /// </summary>
    /// <param name="reader"></param>
    /// <param name="fileName">保存的路径</param>
    public static bool RenderToExcel(IDataReader reader, string fileName)
    {
        try
        {
            using (MemoryStream ms = RenderToExcel(reader))
            {
                return SaveToFile(ms, fileName);
            }
        }
        catch(Exception)
        {
            return false;
        }
    }

    /// <summary>
    /// DataReader转换成Excel文档流，并输出到客户端
    /// </summary>
    /// <param name="reader"></param>
    /// <param name="context">HTTP上下文</param>
    /// <param name="fileName">输出的文件名</param>
    public static void RenderToExcel(IDataReader reader, HttpContext context, string fileName)
    {
        using (MemoryStream ms = RenderToExcel(reader))
        {
            RenderToBrowser(ms, context, fileName);
        }
    }
    /// <summary>
    /// 多个sheet
    /// </summary>
    /// <param name="table"></param>
    /// <param name="context"></param>
    /// <param name="fileName"></param>
    public static void RenderToExcelSheets(DataSet table, HttpContext context, string fileName)
    {
        using (MemoryStream ms = ExportToExcelForSheets(table,"1,2"))
        {
            RenderToBrowser(ms, context, fileName);
        }
    }
   /// <summary>
   /// 多个sheet
   /// </summary>
   /// <param name="table"></param>
   /// <param name="sheetName"></param>
   /// <returns></returns>
    public static MemoryStream ExportToExcelForSheets(DataSet ds, string sheetName)
    {
        IWorkbook workbook = new HSSFWorkbook();
        MemoryStream ms = new MemoryStream();
        string[] sheetNames = sheetName.Split(',');
        for (int i = 0; i < ds.Tables.Count; i++)
        {
            ISheet sheet = workbook.CreateSheet(ds.Tables[i].TableName);
            IRow headerRow = sheet.CreateRow(0);
            // handling header.
            foreach (DataColumn column in ds.Tables[i].Columns)
                headerRow.CreateCell(column.Ordinal).SetCellValue(column.Caption);
            // handling value.
            int rowIndex = 1;
            foreach (DataRow row in ds.Tables[i].Rows)
            {
                IRow dataRow = sheet.CreateRow(rowIndex);

                foreach (DataColumn column in ds.Tables[i].Columns)
                {

                    if (column.Caption == "URL地址" || column.Caption == "页面地址" || column.Caption == "url" || column.Caption == "地址")
                    {
                        #region 设置超链接
                        ICell cell = dataRow.CreateCell(column.Ordinal);//创建单元格  
                        cell.SetCellValue(row[column].ToString());//设置显示文本  
                        HSSFHyperlink link = new HSSFHyperlink(HyperlinkType.Url);//建一个HSSFHyperlink实体，指明链接类型为URL（这里是枚举，可以根据需求自行更改）  
                        link.Address = row[column].ToString();//给HSSFHyperlink的地址赋值  
                        cell.Hyperlink = link;//将链接方式赋值给单元格的Hyperlink即可将链接附加到单元格上   
                        #endregion
                        #region 设置字体
                        IFont font = workbook.CreateFont();//创建字体样式  
                        font.Color = HSSFColor.Blue.Index;//设置字体颜色  
                        ICellStyle style = workbook.CreateCellStyle();//创建单元格样式  
                        style.SetFont(font);//设置单元格样式中的字体样式  
                       
                        cell.CellStyle = style;//为单元格设置显示样式   
                        #endregion
                    }
                    else
                    {
                        dataRow.CreateCell(column.Ordinal).SetCellValue(row[column].ToString());
                    }
                }

                rowIndex++;
            }
            if (i==1)
            {
                sheet.SetColumnWidth(0, 35 * 256);
                sheet.SetColumnWidth(1, 5 * 256);
                sheet.SetColumnWidth(2, 70 * 256);
                sheet.SetColumnWidth(3, 45 * 256);
                sheet.SetColumnWidth(4, 60 * 256);
            }
        }
       
        workbook.Write(ms);
        ms.Flush();
        ms.Position = 0;
        workbook = null;
        return ms;
    }
 
    #region  带格式(超链接、列宽)设置的导出excel
    /// <summary>
    /// DataTable转换成Excel文档流，并输出到客户端,并且添加超链接以及限制列宽
    /// </summary>
    /// <param name="table"></param>
    /// <param name="response"></param>
    /// <param name="fileName">输出的文件名</param>
    public static void SetRenderToExcel(DataTable table, HttpContext context, string fileName)
    {
        using (MemoryStream ms = CreateExcel(table))
        {
            RenderToBrowser(ms, context, fileName);
        }
    }
    /// <summary>
    /// DataTable转换成Excel文档流并且添加超链接以及限制列宽
    /// </summary>
    /// <param name="table"></param>
    /// <returns></returns>
    public static MemoryStream CreateExcel(DataTable table)
    {
        MemoryStream ms = new MemoryStream();

        using (table)
        {
          //  using (IWorkbook workbook = new HSSFWorkbook())
          //  {
               // using (ISheet sheet = workbook.CreateSheet())
              //  {

            IWorkbook workbook = new HSSFWorkbook();
            ISheet sheet = workbook.CreateSheet();

                    IRow headerRow = sheet.CreateRow(0);
                    
                    // handling header.
                    foreach (DataColumn column in table.Columns)
                        headerRow.CreateCell(column.Ordinal).SetCellValue(column.Caption);//If Caption not set, returns the ColumnName value

                    // handling value.
                    int rowIndex = 1;

                    foreach (DataRow row in table.Rows)
                    {
                        IRow dataRow = sheet.CreateRow(rowIndex);

                        foreach (DataColumn column in table.Columns)
                        {
                            if (column.Caption == "URL地址" || column.Caption == "页面地址" || column.Caption == "url")
                            {
                                #region 设置超链接
                                ICell cell = dataRow.CreateCell(column.Ordinal);//创建单元格  
                                cell.SetCellValue(row[column].ToString());//设置显示文本  
                                HSSFHyperlink link = new HSSFHyperlink(HyperlinkType.Url);//建一个HSSFHyperlink实体，指明链接类型为URL（这里是枚举，可以根据需求自行更改）  
                                link.Address = row[column].ToString();//给HSSFHyperlink的地址赋值  
                                cell.Hyperlink = link;//将链接方式赋值给单元格的Hyperlink即可将链接附加到单元格上   
                                #endregion
                                #region 设置字体
                                IFont font = workbook.CreateFont();//创建字体样式  
                                font.Color = HSSFColor.Blue.Index;//设置字体颜色  
                                ICellStyle style = workbook.CreateCellStyle();//创建单元格样式  
                                style.SetFont(font);//设置单元格样式中的字体样式  
                                cell.CellStyle = style;//为单元格设置显示样式   
                                #endregion
                            }
                            else
                            {
                                if (row[column].ToString().Length > 32767)
                                    dataRow.CreateCell(column.Ordinal).SetCellValue(row[column].ToString().Substring(0,32766));
                                else
                                    dataRow.CreateCell(column.Ordinal).SetCellValue(row[column].ToString());
                            }
                        }

                        rowIndex++;
                    }
                    SetSizeColumns(sheet);//设置列宽
                    workbook.Write(ms);
                    ms.Flush();
                    ms.Position = 0;
                }
           // }
       // }
        return ms;
    }
    /// <summary>
    /// 设置Excel列宽
    /// </summary>
    /// <param name="sheet">Excel表</param>
    private static void SetSizeColumns(ISheet sheet)
    {
        if (sheet.PhysicalNumberOfRows > 0)
        {
            IRow headerRow = sheet.GetRow(0);

            for (int i = 0, l = headerRow.LastCellNum; i < l; i++)
            {
                switch (l)//列数
                {
                    case 14://
                        if (i == 0 || i == 5)//内容列和url列
                        {
                            sheet.SetColumnWidth(i, 50 * 256);
                        }
                        else
                            sheet.AutoSizeColumn(i);
                        break;
                    case 17://
                        if (i == 1 || i == 2)//标题和url
                            sheet.SetColumnWidth(i, 50 * 256);
                        else
                            sheet.AutoSizeColumn(i);
                        break;
                    case 32://
                        if (i == 6 || i == 13)//url和标题
                            sheet.SetColumnWidth(i, 50 * 256);
                        else
                            sheet.AutoSizeColumn(i);
                        break;
                    case 13://
                        if (i == 0 || i == 4 || i == 12)//标题url摘要
                            sheet.SetColumnWidth(i, 50 * 256);
                        else
                            sheet.AutoSizeColumn(i);
                        break;
                    default: break;
                }
                #region 
                //if (l == 14)//如果是舆情情报有害模块的默认格式
                //{
                //    if (i == 0||i==5)//内容列和url列
                //    {
                //        sheet.SetColumnWidth(i,50*256);
                //    }
                //    else
                //        sheet.AutoSizeColumn(i);
                //}
                //else if (l == 17)//有害信息处置模块下的默认格式
                //{
                //    if (i == 1 || i == 2)//标题和url
                //        sheet.SetColumnWidth(i, 50 * 256);
                //    else
                //        sheet.AutoSizeColumn(i);
                //}
                //else if (l == 32)//公安部有害信息格式
                //{
                //    if (i == 6 || i == 13)//url和标题
                //        sheet.SetColumnWidth(i, 50 * 256);
                //    else
                //        sheet.AutoSizeColumn(i);
                //}
                //else if (l == 13)//舆情导控导出
                //{

                //}
                #endregion
            }
        }
    }
    #endregion
    /// <summary>
    /// DataTable转换成Excel文档流
    /// </summary>
    /// <param name="table"></param>
    /// <returns></returns>
    public static MemoryStream RenderToExcel(DataTable table)
    {
        MemoryStream ms = new MemoryStream();

        using (table)
        {
            //using (IWorkbook workbook = new HSSFWorkbook())
            //{
            //    using (ISheet sheet = workbook.CreateSheet())
            //    {
            IWorkbook workbook = new HSSFWorkbook();
            ISheet sheet = workbook.CreateSheet();

                    IRow headerRow = sheet.CreateRow(0);

                    // handling header.
                    foreach (DataColumn column in table.Columns)
                        headerRow.CreateCell(column.Ordinal).SetCellValue(column.Caption);//If Caption not set, returns the ColumnName value

                    // handling value.
                    int rowIndex = 1;

                    foreach (DataRow row in table.Rows)
                    {
                        IRow dataRow = sheet.CreateRow(rowIndex);

                        foreach (DataColumn column in table.Columns)
                        {
                            dataRow.CreateCell(column.Ordinal).SetCellValue(row[column].ToString());
                        }

                        rowIndex++;
                    }
                    AutoSizeColumns(sheet);

                    workbook.Write(ms);
                    ms.Flush();
                    ms.Position = 0;
                //}
          //  }
        }
        return ms;
    }

    /// <summary>
    /// dataset转换成Excel文档流
    /// </summary>
    /// <param name="table"></param>
    /// <returns></returns>
    public static MemoryStream RenderToExcel(DataSet dtset)
    {
        MemoryStream ms = new MemoryStream();
        IWorkbook workbook = new HSSFWorkbook();
        if (dtset != null && dtset.Tables.Count > 0)
        {
            for (int i = 0; i < dtset.Tables.Count; i++)
            {
                MemoryStream ms_result = new MemoryStream();
                DataTable table = dtset.Tables[i];
                //using (ISheet sheet = workbook.CreateSheet(table.TableName))
                //{
                ISheet sheet = workbook.CreateSheet(table.TableName);
                    IRow headerRow = sheet.CreateRow(0);
                    // handling header.
                    foreach (DataColumn column in table.Columns)
                        headerRow.CreateCell(column.Ordinal).SetCellValue(column.Caption);//If Caption not set, returns the ColumnName value

                    // handling value.
                    int rowIndex = 1;

                    foreach (DataRow row in table.Rows)
                    {
                        IRow dataRow = sheet.CreateRow(rowIndex);

                        foreach (DataColumn column in table.Columns)
                        {
                            dataRow.CreateCell(column.Ordinal).SetCellValue(row[column].ToString());
                        }

                        rowIndex++;
                    }
                    AutoSizeColumns(sheet);
                    workbook.Write(ms_result);
                    ms_result.Flush();
                    ms_result.Position = 0;
                    ms_result.CopyTo(ms);
               // }
            }
            
        }
        return ms;
    }

    /// <summary>
    /// DataTable转换成Excel文档流，并保存到文件
    /// </summary>
    /// <param name="table"></param>
    /// <param name="fileName">保存的路径</param>
    public static bool RenderToExcel(DataTable table, string fileName)
    {
        try
        {
            using (MemoryStream ms = RenderToExcel(table))
            {
               return SaveToFile(ms, fileName);
            }
        }
        catch (Exception)
        {
            return false;
        }
    }

    /// <summary>
    /// DataTable转换成Excel文档流，并输出到客户端
    /// </summary>
    /// <param name="table"></param>
    /// <param name="response"></param>
    /// <param name="fileName">输出的文件名</param>
    public static void RenderToExcel(DataTable table, HttpContext context, string fileName)
    {
        using (MemoryStream ms = RenderToExcel(table))
        {
            RenderToBrowser(ms, context, fileName);
        }
    }

    /// <summary>
    /// dataset转换成Excel文档流，并输出到客户端
    /// </summary>
    /// <param name="table"></param>
    /// <param name="response"></param>
    /// <param name="fileName">输出的文件名</param>
    public static void RenderToExcel(DataSet table, HttpContext context, string fileName)
    {
        using (MemoryStream ms = RenderToExcel(table))
        {
            RenderToBrowser(ms, context, fileName);
        }
    }

    /// <summary>
    /// Excel文档流是否有数据
    /// </summary>
    /// <param name="excelFileStream">Excel文档流</param>
    /// <returns></returns>
    public static bool HasData(Stream excelFileStream)
    {
        return HasData(excelFileStream, 0);
    }

    /// <summary>
    /// Excel文档流是否有数据
    /// </summary>
    /// <param name="excelFileStream">Excel文档流</param>
    /// <param name="sheetIndex">表索引号，如第一个表为0</param>
    /// <returns></returns>
    public static bool HasData(Stream excelFileStream, int sheetIndex)
    {
        using (excelFileStream)
        {
            //using (IWorkbook workbook = new HSSFWorkbook(excelFileStream))
            //{
            IWorkbook workbook = new HSSFWorkbook(excelFileStream);
                if (workbook.NumberOfSheets > 0)
                {
                    if (sheetIndex < workbook.NumberOfSheets)
                    {
                        //using (ISheet sheet = workbook.GetSheetAt(sheetIndex))
                        //{
                        ISheet sheet = workbook.GetSheetAt(sheetIndex);
                            return sheet.PhysicalNumberOfRows > 0;
                        //}
                    }
                }
            //}
        }
        return false;
    }

    /// <summary>
    /// Excel文档流转换成DataTable
    /// 第一行必须为标题行
    /// </summary>
    /// <param name="excelFileStream">Excel文档流</param>
    /// <param name="sheetName">表名称</param>
    /// <returns></returns>
    public static DataTable RenderFromExcel(Stream excelFileStream, string sheetName)
    {
        return RenderFromExcel(excelFileStream, sheetName, 0);
    }

    /// <summary>
    /// Excel文档流转换成DataTable
    /// </summary>
    /// <param name="excelFileStream">Excel文档流</param>
    /// <param name="sheetName">表名称</param>
    /// <param name="headerRowIndex">标题行索引号，如第一行为0</param>
    /// <returns></returns>
    public static DataTable RenderFromExcel(Stream excelFileStream, string sheetName, int headerRowIndex)
    {
        DataTable table = null;

        using (excelFileStream)
        {
            //using (IWorkbook workbook = new HSSFWorkbook(excelFileStream))
            //{
            //    using (ISheet sheet = workbook.GetSheet(sheetName))
            //    {
            IWorkbook workbook = new HSSFWorkbook(excelFileStream);
            ISheet sheet = workbook.GetSheet(sheetName);
                    table = RenderFromExcel(sheet, headerRowIndex);
            //    }
            //}
        }
        return table;
    }

    /// <summary>
    /// Excel文档流转换成DataTable
    /// 默认转换Excel的第一个表
    /// 第一行必须为标题行
    /// </summary>
    /// <param name="excelFileStream">Excel文档流</param>
    /// <returns></returns>
    public static DataTable RenderFromExcel(string excelFileStream)
    {
        return RenderFromExcel(excelFileStream, 0, 0);
    }

    /// <summary>
    /// Excel文档流转换成DataTable
    /// 第一行必须为标题行
    /// </summary>
    /// <param name="excelFileStream">Excel文档流</param>
    /// <param name="sheetIndex">表索引号，如第一个表为0</param>
    /// <returns></returns>
    public static DataTable RenderFromExcel(string excelFileStream, int sheetIndex)
    {
        return RenderFromExcel(excelFileStream, sheetIndex, 0);
    }

    /// <summary>
    /// Excel文档流转换成DataTable
    /// </summary>
    /// <param name="excelFileStream">Excel文档流</param>
    /// <param name="sheetIndex">表索引号，如第一个表为0</param>
    /// <param name="headerRowIndex">标题行索引号，如第一行为0</param>
    /// <returns></returns>
    public static DataTable RenderFromExcel(string file, int sheetIndex, int headerRowIndex)
    {
        DataTable table = null;
        string extension = System.IO.Path.GetExtension(file);
        Stream excelFileStream = FGA_NUtility.FileOper.FileToStream(file);

        using (excelFileStream)
        {
           
            IWorkbook workbook = null;
            if (extension.Equals(".xls"))
            {
                //把xls文件中的数据写入wk中
                workbook = new HSSFWorkbook(excelFileStream);
            }
            else
            {
                //把xlsx文件中的数据写入wk中
                workbook = new XSSFWorkbook(excelFileStream);
            }

            ISheet sheet = workbook.GetSheetAt(sheetIndex);
            table = RenderFromExcel(sheet, headerRowIndex);
        }
        return table;
    }

    /// <summary>
    /// Excel表格转换成DataTable
    /// </summary>
    /// <param name="sheet">表格</param>
    /// <param name="headerRowIndex">标题行索引号，如第一行为0</param>
    /// <returns></returns>
    private static DataTable RenderFromExcel(ISheet sheet, int headerRowIndex)
    {
        DataTable table = new DataTable();

        IRow headerRow = sheet.GetRow(headerRowIndex);
        int cellCount = headerRow.LastCellNum;//LastCellNum = PhysicalNumberOfCells
        int rowCount = sheet.LastRowNum;//LastRowNum = PhysicalNumberOfRows - 1

        //handling header.
        for (int i = headerRow.FirstCellNum; i < cellCount; i++)
        {
            DataColumn column = new DataColumn(headerRow.GetCell(i).StringCellValue);
            table.Columns.Add(column);
        }

        for (int i = (sheet.FirstRowNum + 1); i <= rowCount; i++)
        {
            IRow row = sheet.GetRow(i);
            DataRow dataRow = table.NewRow();

            if (row != null)
            {
                for (int j = row.FirstCellNum; j < cellCount; j++)
                {
                    if (row.GetCell(j) != null)
                        dataRow[j] = GetCellValue(row.GetCell(j));
                }
            }
            table.Rows.Add(dataRow);
        }

        return table;
    }

    /// <summary>
    /// Excel文档导入到数据库
    /// 默认取Excel的第一个表
    /// 第一行必须为标题行
    /// </summary>
    /// <param name="excelFileStream">Excel文档流</param>
    /// <param name="insertSql">插入语句</param>
    /// <param name="dbAction">更新到数据库的方法</param>
    /// <returns></returns>
    public static int RenderToDb(Stream excelFileStream, string insertSql, DBAction dbAction)
    {
        return RenderToDb(excelFileStream, insertSql, dbAction, 0, 0);
    }

    public delegate int DBAction(string sql, params IDataParameter[] parameters);

    /// <summary>
    /// Excel文档导入到数据库
    /// </summary>
    /// <param name="excelFileStream">Excel文档流</param>
    /// <param name="insertSql">插入语句</param>
    /// <param name="dbAction">更新到数据库的方法</param>
    /// <param name="sheetIndex">表索引号，如第一个表为0</param>
    /// <param name="headerRowIndex">标题行索引号，如第一行为0</param>
    /// <returns></returns>
    public static int RenderToDb(Stream excelFileStream, string insertSql, DBAction dbAction, int sheetIndex, int headerRowIndex)
    {
        int rowAffected = 0;
        using (excelFileStream)
        {
            //using (IWorkbook workbook = new HSSFWorkbook(excelFileStream))
            //{
            //    using (ISheet sheet = workbook.GetSheetAt(sheetIndex))
            //    {
            IWorkbook workbook = new HSSFWorkbook(excelFileStream);
            ISheet sheet = workbook.GetSheetAt(sheetIndex);

                    StringBuilder builder = new StringBuilder();

                    IRow headerRow = sheet.GetRow(headerRowIndex);
                    int cellCount = headerRow.LastCellNum;//LastCellNum = PhysicalNumberOfCells
                    int rowCount = sheet.LastRowNum;//LastRowNum = PhysicalNumberOfRows - 1

                    for (int i = (sheet.FirstRowNum + 1); i <= rowCount; i++)
                    {
                        IRow row = sheet.GetRow(i);
                        if (row != null)
                        {
                            builder.Append(insertSql);
                            builder.Append(" values (");
                            for (int j = row.FirstCellNum; j < cellCount; j++)
                            {
                                builder.AppendFormat("'{0}',", GetCellValue(row.GetCell(j)).Replace("'", "''"));
                            }
                            builder.Length = builder.Length - 1;
                            builder.Append(");");
                        }

                        if ((i % 50 == 0 || i == rowCount) && builder.Length > 0)
                        {
                            //每50条记录一次批量插入到数据库
                            rowAffected += dbAction(builder.ToString());
                            builder.Length = 0;
                        }
                    }
            //    }
            //}
        }
        return rowAffected;
    }
}