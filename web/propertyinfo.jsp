<%@page import="entities.Messages"%>
<%@page import="service.UserIO"%>
<%@page import="entities.PropertyPhotos"%>
<%@page import="entities.Property"%>
<%@page import="entities.Property"%>
<%@page import="service.PropertyIO"%>
<%@page import="java.util.Locale"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="entities.User"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="css/style.css"/>
        <script src="javascript/scripts.js" type="text/javascript"></script>
        <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&amp;sensor=false"></script>
        <script src="http://maps.google.com/maps/api/js?sensor=false"></script>
        <script>
            var map;
            var marker;
            var panPoint;
            var property = [];

            function addproperty(lt, ln) {
                property.push(lt);
                property.push(ln);
            }

            function initialize() {
                var mapOptions = {
                    zoom: 7,
                    center: new google.maps.LatLng(38.2749497, 23.8102716)
                };
                map = new google.maps.Map(document.getElementById('map-canvas'),
                        mapOptions);
                setmarker();
            }

            function setmarker() {
                panPoint = new google.maps.LatLng(property[0], property[1]);
                marker = new google.maps.Marker({position: panPoint, title: "Ιδιοκτησία", map: map});
                map.panTo(panPoint);
            }
            google.maps.event.addDomListener(window, 'load', initialize);</script>
        <title>Find A Residence - Προβολή Στοιχίων Ιδιοκτησίας</title>	
    </head>
    <body>
        <%
            User user = (User) session.getAttribute("user");
            String uid = request.getParameter("userid");
            User owner = (User) UserIO.getUser(Integer.parseInt(uid));
            String pid = request.getParameter("pid");
            Property p = PropertyIO.getProperty(owner, owner.getUserId(), pid);
        %>		   
        <div class="onepcssgrid-1200">
            <div class="onerow">
                <div class="col5">
                    <a href="index.jsp"><img src="images/far.png" alt="logo"/></a>
                </div>
                <div class="col7 last">
                    <%
                        if (user == null) {
                    %>
                    <div id='cssmenu'>
                        <ul>
                            <li><a href='register.jsp'>Εγγραφή</a></li>
                            <li onclick="popup('login')"><a href='#'>Σύνδεση</a></li>
                            <li><a href='search.jsp'>Αναζήτηση Ιδιοκτησιών</a></li>
                        </ul>
                    </div>
                    <%} else {%>
                    <div id='cssmenu'>
                        <ul>
                            <li><a href='#'><%=user.getName()%></a>
                                <ul>
                                    <%if (user.isLessor() || user.isSeller()) {%>
                                    <li><a href='myproperties.jsp'>Οι Ιδιοκτησίες Μου</a></li> <%}%>
                                    <li><a href='editprofile.jsp'>Επεξεργασία Προφίλ</a></li>
                                    <li><a href='logout.jsp'>Έξοδος</a></li>
                                </ul></li>
                                <%if (user.isLessor() || user.isSeller()) {%>
                            <li><a href='addproperty.jsp'>Καταχώρηση Ιδιοκτησίας</a></li>
                                <%}%>
                            <li><a href='search.jsp'>Αναζήτηση Ιδιοκτησιών</a></li>
                        </ul>
                        <%}%>
                    </div>
                </div>
                <div id="blanket" style="display:none" onclick="popup('login')"></div>
                <div id="login" style="display:none" >
                    <button type="button" onclick="popup('login')">x</button>
                    <form id="login-form" action="login" method="POST">
                        <input type="text" placeholder="Όνομα Χρήστη" name="username"/>
                        <input type="password" placeholder="Κωδικός" name="password" />
                        <input type="submit" value="Σύνδεση" />
                    </form>
                </div>
            </div>
            <div class="onerow">
                <div class="col12 last" >
                    <h1>Προβολή Στοιχείων Ιδιοκτησίας</h1> </div> </div>

            <div class="onerow">
                <div class="col6">
                    <p><b>Τύπος Συναλλαγής:</b> <%=p.isForSale() ? "Πώληση" : "Ενοικιάση"%></p>
                    <p><b>Τύπος Ιδιοκτησίας:</b> <%=p.isIsApartment() ? "Διαμέρισμα" : "Μονοκατοικία"%></p>
                    <p><b>Ημερομηνία Κατασκευής:</b> <%=p.getBuildDate()%></p>
                    <p><b>Ημερομηνία Ανακαίνισης:</b> <%if (p.getRenovationDate() != null) {
                            out.println(p.getRenovationDate());
                        } else {
                            out.println("-");
                        }%></p>
                    <p><b>Τιμή: </b> <%=p.getPrice().intValue()%></p>      


                    <p><b>Έξοδα Συντήρησης: </b> <%=p.getMaintenanceCharges().intValue()%></p>
                    <p><b>Τετραγωνικά Μέτρα:</b> <%=p.getSqMeters()%></p> 
                    <p><b>Αριθμός Δωματίων: </b> <%=p.getRoomsNo()%></p>   
                    <p><b><%=p.isIsApartment() ? "Όροφος" : "Όροφοι"%>:</b> <%=p.isIsApartment() ? p.getApFloor() : p.getHFloors()%></p>             
                    <p><b>Σύστημα Θέρμανσης:</b> <%if (p.getHeatingSystem().equals("central_diesel")) {
                            out.print("Κεντρική Θέρμανση Πετρελαίου");
                        } else if (p.getHeatingSystem().equals("atomic_diesel")) {
                            out.print("Ατομική Θέρμανση Πετρελαίου");
                        } else if (p.getHeatingSystem().equals("central_gas")) {
                            out.print("Κεντρική Θέρμανση Φυσικού Αερίου");
                        } else if (p.getHeatingSystem().equals("atomic_gas")) {
                            out.print("Ατομική Θέρμανση Φυσικού Αερίου");
                        } else if (p.getHeatingSystem().equals("pelet")) {
                            out.print("Θέρμανση με Pelet");
                        }
                        %></p>
                    <p><b>Κλιματισμός:</b> <%=p.isAirConditioner() ? "Διαθέσιμο" : "Μη Διαθέσιμο"%></p>
                    <p><b>Χώρος Στάθμευσης</b> <%=p.isParking() ? "Διαθέσιμο" : "Μη Διαθέσιμο"%></p>
                    <p><b>Ανελκυστήρας</b> <%=p.isElevator() ? "Διαθέσιμο" : "Μη Διαθέσιμο"%></p>
                    <p><b>Διεύθυνση:</b> <%=p.getAddress1()%>, <%=p.getAddress2()%> <%=p.getAddress3()%> <%=p.getPostalCode()%>,<br/> <%=p.getCity()%>, <%=p.getRegion()%> <%=p.getCountry()%></p>
                    <p><b>Περιγραφή:</b> <br/><%=p.getDescription()%></p>
                    <script>addproperty(<%=p.getLatitude()%>, <%=p.getLongitude()%>, <%=p.getId().getPropertyId()%>, <%=p.getId().getOwnerUserId()%>,<%=p.isForRent()%>, <%=p.isIsApartment()%>, <%=p.getPrice()%>);</script>
                </div>
                <div class="col6 last">
                    <div id="map-canvas" style="height:500px"></div>
                </div>
            </div>
            <div class="onerow">
                <div class="col12 last" >
                    <h1>Φωτογραφίες</h1> </div> </div>
            <div class="onerow">
                <div class="col12 last">
                    <p>
                        <%List<PropertyPhotos> photos = PropertyIO.getPropertyPhotos(Integer.parseInt(pid));
                            for (PropertyPhotos ph : photos) {
                                int z = Character.getNumericValue(ph.getPath().substring(ph.getPath().lastIndexOf("e")).charAt(1));
                        %>
                        <a href="images/propertiespictures/property_picture<%=z%>_us<%=ph.getId().getPropertyOwnerUserId()%>_pr<%=pid%>.jpg" target="_blank"><img id="ppp" src="images/propertiespictures/property_picture<%=z%>_us<%=ph.getId().getPropertyOwnerUserId()%>_pr<%=pid%>.jpg" alt=""/></a>
                            <%}%>
                    </p>
                </div>
            </div>
            <%if ((user == null) || (user != null && p.getId().getOwnerUserId() != user.getUserId())) {%>
            <div class="onerow">
                <div class="col12 last" >
                    <h1>Επικοινωνία</h1> </div> </div>
            <div class="onerow">
                <div class="col6">
                    <h2>Φόρμα Επικοινωνίας</h2>
                    <%if (user != null) {%>
                    <form id="general-form" autocomplete="off" name="pform" method="post" action="sendmsg?sender_id=<%=user.getUserId()%>&amp;owner_id=<%=owner.getUserId()%>&amp;pid=<%=p.getId().getPropertyId()%>">
                        <p class="general">
                            <label for="sendermail">Email Αποστολέα <font color="red">*</font>
                            </label></p>
                        <input type="text" name="sendermail" id="sender"/>   
                        <p class="general">
                            <label for="msg">Μήνυμα <font color="red">*</font>
                            </label></p>
                        <textarea name="msg" rows="5" cols="48" id="msg" >
                        </textarea>
                        <p><input class="buttom" name="submit" id="submit" value="Αποστολή" type="submit"> </p>	 
                    </form><%} else {%>
                    <p> Πρέπει να συνδεθείτε για να έχετε δυνατότητα χρήσης αυτής της λειτουργείας</p>
                    <%}%>
                </div>
                <div class="col6 last" >
                    <h2>Στοιχεία Επικοινωνίας</h2>
                    <p><b>Όνομα Ιδιοκτήτη: </b><%=owner.getName() + " " + owner.getSurname()%>
                    <p><b>Email: </b><a href="emailto:<%=owner.getEmail()%>"><%=owner.getEmail()%></a></p>
                    <p><b>Τηλέφωνο: </b><%=(owner.getTelephone() != null) ? owner.getTelephone() : "-"%>
                    <p><b>Τηλέφωνο 2: </b><%=(owner.getTelephone2() != null) ? owner.getTelephone2() : "-"%>
                </div> 
            </div>
            <%} else if (user != null && user.getUserId() == owner.getUserId()) {
                List<Messages> msgs = PropertyIO.getmsgs(user.getUserId(), Integer.parseInt(pid));
            %>
            <div class="onerow">
                <div class="col12 last">
                    <h1>Ληφθέντα Μηνύματα</h1>
                </div></div>
            <div class="onerow">
                <div class="col12 last">
                    <%if (msgs.size() == 0) { %>
                    <p>Δεν υπάρχει κάποιο μήνυμα σχετικά με αυτή την ιδιοκτησία.</p>
                    <%} else {
                        int i = 1;
                        for (Messages m : msgs) {
                    %>
                    <a href="readmsg.jsp?uid=<%=uid%>&amp;mid=<%=m.getId().getMessageId()%>&amp;pid=<%=pid%>"><b>Μήνυμα <%=i%></b></a><br/>
                    <%i++;
                            }
                        }%>
                </div>
            </div>
            <%}%>
            <div class="onerow">
                <div class="col1">             
                    <a href="index.jsp"><img src="images/farfooter.png" alt="logo"/></a>
                </div>
                <div class="col3"><p><b>Find A Residence &copy;</b><br>Yποστήριξη Αποφάσεων Ενοικίασης/Αγοράς Κατοικίας</p></div>
                <div class="col4">             
                    <p><b>Υλοποιήθηκε από:</b><br/>Κωνσταντίνος Δαλιάνης - 1115201000178<br/>Φάβα Μαρία - 1115201000104</p>
                </div>
                <div class="col4 last">             
                    <p><a href="mailto:admin@far.gr?Subject=Find A Residence" target="_top">Επικοινωνήστε Μαζί μας</a></p>
                </div>
            </div> 
        </div>
    </body>
</html>