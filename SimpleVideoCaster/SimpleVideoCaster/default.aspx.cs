using MediaToolkit;
using MediaToolkit.Model;
using MediaToolkit.Options;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SimpleVideoCaster
{
    public partial class _default : System.Web.UI.Page
    {
        private HttpPostedFile file;

        private const string EXTENSION_AVI = ".avi";
        private const string EXTENSION_MP4 = ".mp4";
        private const string EXTENSION_MOV = ".mov";
        private const string EXTENSION_MKV = ".mkv";

        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void videoUploadButton_Click(object sender, EventArgs e)
        {
            file = Request.Files["videoUpload"];
            bool fileSaved = false;

            // check if the file is empty 
            if (file != null && file.ContentLength > 0)
            {
                try
                {
                    fileSaved = saveFile(file);
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.Message);
                }

                if (fileSaved)
                {
                    try
                    {
                        getThumbnail();
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine(ex.Message);
                    }

                    castButton.Disabled = false;
                }
                else
                {
                    // file wasn't saved
                    // notify user
                }
            }
            else
            {
                // throw error
            }
        }

        private bool saveFile(HttpPostedFile file)
        {
            //
            //  Extremely simplified implementation. Will improve ASAP
            //

            try
            {
                // create the videoupload folder if it doesn't exist
                Directory.CreateDirectory("~/videoupload/");

                // check the extension of the file to see if it's a video file
                string extension = Path.GetExtension(file.FileName);

                string fname = Path.GetFileNameWithoutExtension(file.FileName);
                //file.SaveAs(Server.MapPath(Path.Combine("~/App_Data/", fname)));
                file.SaveAs(Server.MapPath("~/videoUpload/video.mp4"));
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
                return false;
            }

            return true;
        }

        // method to delete the files once the user is done
        private void deleteFolder()
        {
            try
            {
                string[] filepaths = Directory.GetFiles(Server.MapPath("~videoupload/"));
                foreach (string fileName in filepaths)
                {
                    File.Delete(fileName);
                }

                Directory.Delete(Server.MapPath("~/videoupload/"));
            }
            catch (Exception e)
            {
                // handle exception, maybe try again
            }
        }

        // method that gets a thumbnail image from the uploaded video, saves the file, and sets the thumbnail imageurl
        private void getThumbnail()
        {
            var inputFile = new MediaFile { Filename = Server.MapPath("~/videoupload/video.mp4") };
            var outputFile = new MediaFile { Filename = Server.MapPath("~/videoUpload/thumbnanail.jpg") };

            var engine = new Engine();

            engine.GetMetadata(inputFile);

            var options = new ConversionOptions { Seek = TimeSpan.FromSeconds(15) };
            engine.GetThumbnail(inputFile, outputFile, options);

            

            thumbnailImage.ImageUrl = Server.MapPath("~videoupload/video.mp4");
        }
    }
}