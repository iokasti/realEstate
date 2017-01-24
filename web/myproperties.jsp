<%@page import="service.PropertyIO"%>
<%@page import="service.UserIO"%>
<%@page import="java.util.Set"%>
<%@page import="org.hibernate.Session"%>
<%@page import="db.HibernateUtil"%>
<%@page import="entities.Property"%>
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
            var lastinfowindow = null;
            var last_i = null;
            var map;
            var properties_matrix;
            var markers_matrix = new Array();
            var info_windows = new Array();
            var iMax = -1;
            var current_i = 0;

            function generatepropertiesmatrix(giMax) {
                iMax = giMax;
                properties_matrix = new Array(iMax);
                for (i = 0; i < iMax; i++) {
                    properties_matrix[i] = new Array(6);
                }
            }

            function addproperty(lt, ln, id, username, trans_t, prop_t, price) {
                properties_matrix[current_i][0] = lt;
                properties_matrix[current_i][1] = ln;
                properties_matrix[current_i][2] = id;
                properties_matrix[current_i][3] = username;
                if (trans_t) {
                    properties_matrix[current_i][4] = "Ενοικίαση";
                } else {
                    properties_matrix[current_i][4] = "Πώληση";
                }
                if (prop_t) {
                    properties_matrix[current_i][5] = "Διαμέρισμα";
                } else {
                    properties_matrix[current_i][5] = "Μονοκατοικία";
                }
                properties_matrix[current_i][6] = price;
                current_i++;
            }

            function initialize() {
                var mapOptions = {
                    zoom: 7,
                    center: new google.maps.LatLng(38.2749497, 23.8102716)
                };
                map = new google.maps.Map(document.getElementById('map-canvas'),
                        mapOptions);
                setmarkers();
            }

            function setmarkers() {
                markers_matrix = new Array();
                var panPoint;
                var i;
                var marker;
                for (i = 0; i < iMax; i++) {
                    panPoint = new google.maps.LatLng(properties_matrix[i][0], properties_matrix[i][1]);
                    marker = new google.maps.Marker({position: panPoint, title: "Ιδιοκτησία ".concat(i + 1), map: map});
                    markers_matrix.push(marker);
                    var description = "<div style=\"width:200px; height:200px; font-size:15px; font-family:'Open Sans',sans-serif;\"><p><div style=\"font-size:18px;font-weight: 700;\">Ιδιοκτησία " + (i + 1) + "</div></p><p>Τύπος Συναλλαγής: " + properties_matrix[i][4] + "<br/>Τύπος Ιδιοκτησίας: " + properties_matrix[i][5] + "<br/>Τιμή: " + properties_matrix[i][6] + "<br/><a href=\"propertyinfo.jsp?userid=" + properties_matrix[i][3] + "&pid=" + properties_matrix[i][2] + "\">Περισσότερες Πληροφορίες</a><br/><a href=\"editproperty.jsp?userid=" + properties_matrix[i][3] + "&pid=" + properties_matrix[i][2] + "\">Επεξεργασία Στοιχίων Ιδιοκτησίας</a></p></div>";
                    bindInfoWindow(marker, description.toString(), i);
                }
                autocenter();
            }

            function bindInfoWindow(marker, description, i) {
                var infoWindow = new google.maps.InfoWindow({
                    content: description
                });
                info_windows.push(infoWindow);
                google.maps.event.addListener(marker, 'click', function () {
                    if (lastinfowindow !== null) {
                        lastinfowindow.close();
                        document.getElementById("pinfo_" + last_i).style.background = "#fff";
                    }
                    if (lastinfowindow === infoWindow) {
                        lastinfowindow = null;
                        document.getElementById("pinfo_" + last_i).style.background = "#fff";
                        last_i = null;
                    } else {
                        infoWindow.open(map, marker);
                        lastinfowindow = infoWindow;
                        last_i = i;
                        document.getElementById("pinfo_" + i).style.background = "#FFF3DF";
                    }
                });
            }

            function autocenter() {
                var bounds = new google.maps.LatLngBounds();
                $.each(markers_matrix, function (index, marker) {
                    bounds.extend(marker.position);
                });
                map.setCenter(bounds.getCenter());
                map.fitBounds(bounds);
            }

            function openinfowindow(i) {
                if (lastinfowindow !== null) {
                    lastinfowindow.close();
                    document.getElementById("pinfo_" + last_i).style.background = "#fff";
                }
                if (lastinfowindow === info_windows[i]) {
                    lastinfowindow = null;
                    last_i = null;
                    document.getElementById("pinfo_" + last_i).style.background = "#fff";
                } else {
                    info_windows[i].open(map, markers_matrix[i]);
                    lastinfowindow = info_windows[i];
                    last_i = i;
                    document.getElementById("pinfo_" + i).style.background = "#FFF3DF";
                }
            }

            google.maps.event.addDomListener(window, 'load', initialize);</script>
        <title>Find A Residence - Οι Ιδιοκτησίες Μου</title>	
    </head>
    <body>
        <%
            User user = (User) session.getAttribute("user");
            if (user == null || (!user.isLessor() && !user.isSeller())) {
                response.sendRedirect("index.jsp");
            }
        %>		   

        <div class="onepcssgrid-1200">
            <div class="onerow">
                <div class="col5">
                    <a href="index.jsp"><img src="images/far.png" alt="logo"/></a>
                </div>
                <div class="col7 last">
                    <div id='cssmenu'>
                        <ul>
                            <li><a href='#'><%=user.getName()%></a>
                                <ul>
                                    <li><a href='myproperties.jsp'>Οι Ιδιοκτησίες Μου</a></li>
                                    <li><a href='editprofile.jsp'>Επεξεργασία Προφίλ</a></li>
                                    <li><a href='logout.jsp'>Έξοδος</a></li>
                                </ul></li>
                                <%if (user.isLessor() || user.isSeller()) {%>
                            <li><a href='addproperty.jsp'>Καταχώρηση Ιδιοκτησίας</a></li>
                                <%}%>
                            <li><a href='search.jsp'>Αναζήτηση Ιδιοκτησιών</a></li>
                        </ul>
                    </div>
                </div>
            </div>         
            <div class="onerow"><div class="col12 last"><h1>Οι Ιδιοκτησίες Μου</h1></div></div>
            <div class="onerow">
                <div class="col6" id="scr">
                    <%
                        List<Property> p = PropertyIO.getProperties(user.getUserId(), user.getUsername());
                    %>
                    <script>generatepropertiesmatrix(<%=p.size()%>);</script>
                    <%         int i = 1;
                        for (Property property : p) {

                    %>
                    <div id="pinfo_<%=(i - 1)%>" onclick="openinfowindow(<%=(i - 1)%>)" style="cursor:pointer">
                        <h3>Ιδιοκτησία <%=i%></h3>
                        <p><%if (property.isForRent()) {
                                out.println("Τύπος Συναλλαγής: Ενοικίαση<br/>");
                            } else {
                                out.println("Τύπος Συναλλαγής: Πώληση</br>");
                            }
                            if (property.isIsApartment()) {
                                out.println("Τύπος Ιδιοκτησίας: Διαμέρισμα<br/>");
                            } else {
                                out.println("Τύπος Ιδιοκτησίας: Μονοκατοικία<br/>");
                            }
                            out.println("Τιμή: " + property.getPrice() + "<br/>");
                            out.println("<a href=\"propertyinfo.jsp?userid=" + property.getId().getOwnerUserId() + "&pid=" + property.getId().getPropertyId() + "\" >Περισσότερες Πληροφορίες</a><br/>");
                            out.println("<a href=\"editproperty.jsp?userid=" + property.getId().getOwnerUserId() + "&pid=" + property.getId().getPropertyId() + "\" >Επεξεργασία Στοιχίων Ιδιοκτησίας</a><br/>");
                            %></p>
                    </div>
                    <script>addproperty(<%=property.getLatitude()%>, <%=property.getLongitude()%>, <%=property.getId().getPropertyId()%>, <%=property.getId().getOwnerUserId()%>,<%=property.isForRent()%>, <%=property.isIsApartment()%>, <%=property.getPrice()%>);</script>
                    <% i++;
                        }%>
                </div>
                <div class="col6 last">
                    <div id="map-canvas" style="height:700px"></div>
                </div>
            </div>
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