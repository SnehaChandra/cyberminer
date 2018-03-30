<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

    <!-- jQuery library -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

    <!-- Latest compiled JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <script>
        function chectmod(id) {
            console.log(id);
            $('#myModal').modal('show');
            document.getElementById('id').value=id;
        }
        function openNwModal() {
            $('#noiseWordsModal').modal('show');
        }
        function openOptModal() {
            $('#searchOptionsModal').modal('show');
        }
        function updateHitrate(e,id,location){
            e.preventDefault();
            ajaxfunction(id);
            window.open(location,'_blank');
        }
        function ajaxfunction(pId){

            var submit_url = "/url/hitrate?urlId="+pId;
            $.ajax({
                type : "POST",
                contentType : "application/json",
                url : submit_url,
                success : function(data) {
                    console.log("SUCCESS: ", data);
                },
                error : function(e) {
                    console.log("ERROR: ", e);
                },
                done : function(e) {
                    console.log("DONE");
                }
            });

        }
    </script>
</head>

<body>
<div class="container">
    <div class="masthead">
        <h3 class="text-muted">Cyberminer</h3>


        <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
            <div class="container">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                </div>

                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <ul class="nav navbar-nav">
                        <li class="active">
                            <a href="#home" aria-controls="profile" role="tab" data-toggle="tab">Cyberminer</a>
                        </li>
                        <li>
                            <a href="#addUrl" aria-controls="profile" role="tab" data-toggle="tab">Add</a>
                        </li>
                        <li>
                            <a href="#delUrl" aria-controls="profile" role="tab" data-toggle="tab">Delete</a>
                        </li>
                        <li>
                            <a href="#config" aria-controls="profile" role="tab" data-toggle="tab">Configuration</a>
                        </li>
                    </ul>
                </div>
                <!-- /.navbar-collapse -->
            </div>
            <!-- /.container -->
        </nav>

        <div class="tab-content">
            <div role="tabpanel" class="tab-pane active" id="home">
                <form action="/searchUrl" method="post">
                    <div class="form-group row">
                        <label class="col-2 col-form-label">Search</label>
                        <div class="col-10">
                            <input class="form-control" name="search" type="search" placeholder="What are you looking for?" id="search" aria-describedby="basic-addon1" required="">
                        </div>
                    </div>

                    <center>
                        <button type="submit" class="btn btn-primary btn-lg">Search</button>
                    </center>
                </form>
            </div>

            <div role="tabpanel" class="tab-pane" id="addUrl">
                <form action="/url/addUrl" method="post">

                    <div class="form-group row">
                        <label for="url" class="col-2 col-form-label">URL</label>
                        <div class="col-10">
                            <input class="form-control" id="url" name="url" type="url" placeholder="" aria-describedby="basic-addon1" required>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="description" class="col-2 col-form-label">Description</label>
                        <div class="col-10">
                            <input class="form-control" name="description" type="description" id="description" aria-describedby="basic-addon1" required>
                        </div>
                    </div>
                    <center>
                        <button type="submit" class="btn btn-primary btn-lg">Add</button>
                    </center>


                </form>
            </div>

            <div role="tabpanel" class="tab-pane" id="delUrl">

                <div style ="padding-top: 70px;padding: 1.5rem;margin-right: 0; margin-bottom: 0; margin-left: 0; border-width: .2rem;">
                    <table class="table table-hover table-bordered">
                        <thead class="thead-inverse">
                        <tr>
                            <th>URL</th>
                            <th>DESCRIPTION</th>
                            <th>HITRATE</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${urls}" var="temp">
                            <tr>
                                <td class="align-middle">
                                    <a href="${temp.getUrlLink()}" onclick="updateHitrate(event,${temp.getId()},'${temp.getUrlLink()}')" target="_blank">${temp.getUrlLink()}</a>
                                </td>
                                <td class="align-middle">
                                        ${temp.getDescription()}
                                </td>
                                <td class="align-middle">
                                        ${temp.getHitrate()}
                                </td>
                                <td>
                                    <button type="submit"
                                            class="btn btn-danger"
                                            onclick='chectmod("${temp.getId()}")'>DELETE</button>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>

                </div>


            </div>

            <div role="tabpanel" class="tab-pane" id="config">
                <center>
                    <button type="submit" onclick='openNwModal()' class="btn btn-primary btn-lg">Add Noise Words</button>
                    <button type="submit" onclick='openOptModal()' class="btn btn-primary btn-lg">Change Search Option</button>
                </center>
            </div>

        </div>
    </div>
</div>



<!-- Modal -->

<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h5 class="modal-title" id="myModalLabel">Delete URL</h5>
            </div>
            <div class="modal-body">
                <form action="/url/deleteUrl" method="post">
                    <div class="form-group">
                        <label for="id" class="form-control-label"><b>Id:</b></label>
                        <input id="id" type="text" name="id" class="form-control" readonly>
                    </div>
                    <button type="submit" class="btn btn-primary">Delete</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Modal -->

<div class="modal fade" id="noiseWordsModal" tabindex="-1" role="dialog" aria-labelledby="noiseWordsModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h5 class="modal-title" id="noiseWordsModalLabel">Noise Words</h5>
            </div>
            <div class="modal-body">
                <form action="/configuration/noiseWords" method="post">
                    <div class="form-group">
                        <label for="noiseWords" class="form-control-label"><b>Noise Words:</b></label>
                        <input id="noiseWords" placeholder="Enter Noise Words separated by ','" type="text" name="noiseWords" required class="form-control" >
                    </div>
                    <button type="submit" class="btn btn-primary">Add</button>
            </form>
            </div>
        </div>
    </div>
</div>

<!-- Modal -->

<div class="modal fade" id="searchOptionsModal" tabindex="-1" role="dialog" aria-labelledby="searchOptionsModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h5 class="modal-title" id="searchOptionsModalLabel">Search Options</h5>
            </div>
            <div class="modal-body">
                <form action="/configuration/searchOpt" method="post">
                    <c:forEach items="${options}" var="opt">
                    <div class="radio">
                        <label><input type="radio" value=${opt.getId()} ${opt.getFlag() == 1 ? 'checked' : ''} name="searchOption">${opt.getSearchopt()}</label>
                    </div>
                    </c:forEach>
                    <button type="submit" class="btn btn-primary">Add</button>
                </form>
            </div>
        </div>
    </div>
</div>



</body>
</html>