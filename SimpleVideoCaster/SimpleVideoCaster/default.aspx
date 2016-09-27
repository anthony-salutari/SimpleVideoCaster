<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="_default.aspx.cs" Inherits="SimpleVideoCaster._default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Simple Video Caster</title>

    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <link href="Content/Site.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/37fe16a240.js"></script>
    <script src="Scripts/jquery-1.10.2.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <script src="https://www.gstatic.com/cv/js/sender/v1/cast_sender.js"></script>
    <script src="Scripts/cast_logic.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-slider/9.1.3/bootstrap-slider.min.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-slider/9.1.3/css/bootstrap-slider.min.css" rel="stylesheet" />

    <script type="text/javascript">
        $(document).ready(function () {
            var progressControl = $('#progressControl').slider();
            var volumeControl = $('#volumeControl').slider();
            var oldVolume;
            var volumeIncrement = 10;

            // set up sliders
            $('#progressControl').slider({
                formatter: function (value) {
                    return value;
                }
            });

            $('#volumeControl').slider({
                formatter: function (value) {
                    return value;
                }
            });

            // set up volume buttons
            $('#muteButton').click(function () {
                var currentVolume = volumeControl.slider('getValue');

                if (currentVolume > 0) {
                    oldVolume = currentVolume;
                    volumeControl.slider('setValue', 0);
                } else {
                    volumeControl.slider('setValue', oldVolume);
                }
            });

            $('#volumeUpButton').click(function () {
                var currentVolume = volumeControl.slider('getValue');
                volumeControl.slider('setValue', currentVolume + volumeIncrement);
            });

            $('#volumeDownButton').click(function () {
                var currentVolume = volumeControl.slider('getValue');
                volumeControl.slider('setValue', currentVolume - volumeIncrement);
            });

            // set up playback buttons
            $('#rewindButton').click(function () {

            });

            $('#playButton').click(function () {

            });

            $('#pauseButton').click(function () {

            });

            $('#stopButton').click(function () {

            });

            $('#forwardButton').click(function () {

            });
        });
    </script>

</head>
<body>
    <form id="form1" method="post" runat="server" enctype="multipart/form-data">

    <!-- HEADER -->
    <nav class="navbar navbar-inverse">
        <div class="container-fluid">
            <div class="navbar-header">
                <a class="navbar-brand" href="#">Simple Video Caster</a>
            </div>
            <ul class="nav navbar-nav">
                <li class="active"><a href="#">Home</a></li>
                <li><a href="#aboutModal" data-toggle="modal">About</a></li>
            </ul>
        </div>
    </nav>

    <!-- VIDEO UPLOAD -->
    <div class="col-md-2"></div>
    <div id="uploadDiv" class="container-fluid" runat="server">
        <div class="col-md-4">
            <h2>Video File</h2>
            <label class="btn btn-default" for="videoUpload">
            <input id="videoUpload" type="file" style="display:none;" onchange="$('#video-file-info').html($(this).val());" runat="server" name="videoUpload" />
            Browse...
            </label>
            <asp:Button ID="videoUploadButton" runat="server" Text="Upload" CssClass="btn btn-default" OnClick="videoUploadButton_Click" />
            <h4><span class='label label-primary' id="video-file-info"></span></h4>
            <br />

            <asp:Image ID="thumbnailImage" runat="server" Width="500px" Height="500px"/>
            
            <h3>Playback Controls</h3>
            <div class="btn-group">
                <button type="button" id="rewindButton" class="btn btn-default"><i class="fa fa-backward" aria-hidden="true"></i></button>
                <button type="button" id="playButton" class="btn btn-default"><i class="fa fa-play" aria-hidden="true"></i></button>
                <button type="button" id="pauseButton" class="btn btn-default"><i class="fa fa-pause" aria-hidden="true"></i></button>
                <button type="button" id="stopButton" class="btn btn-default"><i class="fa fa-stop" aria-hidden="true"></i></button>
                <button type="button" id="forwardButton" class="btn btn-default"><i class="fa fa-forward" aria-hidden="true"></i></button>
            </div>
            <br />

            <h3>Progress</h3>
            <input id="progressControl" data-slider-id='progressSlider' type="text" data-slider-min="0" data-slider-max="100" data-slider-step="1" data-slider-value="0" />

            <h3>Volume</h3>
            <div class="btn-group">
                <button type="button" id="volumeUpButton" class="btn btn-default"><i class="fa fa-volume-up" aria-hidden="true"></i></button>
                <button type="button" id="volumeDownButton" class="btn btn-default"><i class="fa fa-volume-down" aria-hidden="true"></i></button>
                <button type="button" id="muteButton" class="btn btn-default"><i class="fa fa-volume-off" aria-hidden="true"></i></button>
            </div>
            &nbsp;&nbsp;&nbsp;
            <input id="volumeControl" data-slider-id='volumeSlider' type="text" data-slider-min="0" data-slider-max="100" data-slider-step="1" data-slider-value="100" />
        </div>
    </div>

    <!-- CAPTIONS UPLOAD -->
    <div id="captionsDiv" class="container-fluid" runat="server">
        <div class="col-md-4">
            <h2>Caption File (Optional)</h2>
            <label class="btn btn-default" for="captionUpload">
            <input id="captionUpload" type="file" style="display:none;" onchange="$('#caption-file-info').html($(this).val());" />
            Browse...
            </label>
            <asp:Button ID="captionUploadButton" runat="server" Text="Upload" CssClass="btn btn-default" OnClientClick="return false;" />
            <h4><span class='label label-default' id="caption-file-info"></span></h4>
            <br />

            <h3>Caption Size</h3>
            <div class="btn-group">
                <button type="button" class="btn btn-default">Small</button>
                <button type="button" class="btn btn-default">Medium</button>
                <button type="button" class="btn btn-default">Large</button>
            </div>
        </div>
    </div>
    <div class="col-md-2"></div>

    <div class="col-md-2 col-md-offset-5 container-fluid">
        <br />
        <br />
        <button type="button" id="castButton" class="btn btn-primary btn-block btn-lg" onclick="launchApp()" runat="server" disabled>Cast</button>
    </div>

    <!-- MODALS -->
    <div class="modal fade" id="aboutModal" tabindex="-1" role="dialog" aria-labelledby="title" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="title">About</h4>
                </div>
                <div class="modal-body">
                    Copyright 2016 Anthony Salutari
                    <br />
                    <br />
                    <a class="btn btn-default" href="http://github.com/anthony-salutari">
                        <i class="fa fa-github-square" aria-hidden="true"></i>
                        Github
                    </a>
                    <a class="btn btn-default" href="http://www.apache.org/licenses/LICENSE-2.0.txt">
                        <i class="fa fa-info-circle" aria-hidden="true"></i>
                        License Information
                    </a>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
    </form>
</body>
</html>
