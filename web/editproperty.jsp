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

            function getlatlng() {
                geocoder = new google.maps.Geocoder();
                var address1 = document.getElementById("address1").value;
                var address2 = document.getElementById("address2").value;
                var address3 = document.getElementById("address3").value;
                var city = document.getElementById("city").value;
                var region = document.getElementById("region").value;
                var postalCode = document.getElementById("postalCode").value;
                var country = document.getElementById("country").value;
                var address = address1 + " " + address2 + " " + address3 + " " + city + " " + region + " " + postalCode + " " + country;
                geocoder.geocode({'address': address}, function (results, status) {
                    if (status === google.maps.GeocoderStatus.OK) {
                        var latitude = results[0].geometry.location.lat();
                        var longitude = results[0].geometry.location.lng();
                        document.getElementById('lat').value = latitude.toString();
                        document.getElementById('lng').value = longitude.toString();
                    }
                });
                if (address1 !== "" && city !== "" && region !== "" && postalCode !== "") {
                    panPoint = new google.maps.LatLng(document.getElementById("lat").value, document.getElementById("lng").value);
                    marker.setPosition(panPoint);
                    map.panTo(panPoint);
                }
            }

            google.maps.event.addDomListener(window, 'load', initialize);</script>
        <title>Find A Residence - Επεξεργασία Στοιχίων Ιδιοκτησίας</title>	
    </head>
    <body>
        <%
            User user = (User) session.getAttribute("user");
            String uid = request.getParameter("userid");
            if (user == null || (!user.isLessor() && !user.isSeller()) || Integer.parseInt(uid) != user.getUserId()) {
                response.sendRedirect("index.jsp");
            }
            String pid = request.getParameter("pid");
            Property p = PropertyIO.getProperty(user, user.getUserId(), pid);
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
            <div class="onerow">
                <div class="col12 last" >
                    <h1>Επεξεργασία Στοιχείων Ιδιοκτησίας</h1> </div> </div>
            <div class="onerow">
                <div class="col6">
                    <form id="general-form" autocomplete="off" name="pform" method="post" action="editproperty?username=<%=user.getUsername()%>&amp;pid=<%=pid%>" onsubmit="return validatePropertyForm()">
                        <fieldset> 
                            <label for="forSale_forRent">Πώληση ή Ενοικίαση <font color="red">*</font>
                            </label>
                            <select name="forSale_forRent" id="forSale_forRent">  
                                <%if (user.isSeller() && user.isLessor()) {%>
                                <option value="forSale" <%if (p.isForSale()) {
                                        out.print("selected");
                                    } %>>Πώληση</option>
                                <option value="forRent" <%if (p.isForRent()) {
                                        out.print("selected");
                                    } %>>Ενοικίαση</option>
                                <%} else if (user.isSeller()) {%>
                                <option value="forSale" <%if (p.isForSale()) {
                                        out.print("selected");
                                    } %>>Πώληση</option>
                                <%} else {%>
                                <option value="forRent" <%if (p.isForRent()) {
                                        out.print("selected");
                                    } %>>Ενοικίαση</option>
                                <%}%>
                            </select>
                            <label for="isApartment_isHouse">Τύπος Ιδιοκτησίας <font color="red">*</font>
                            </label>
                            <select name="isApartment_isHouse" id="isApartment_isHouse">           
                                <option value="isApartment" <%if (p.isIsApartment()) {
                                        out.print("selected");
                                    } %>>Διαμέρισμα</option>
                                <option value="isHouse" <%if (p.isIsHouse()) {
                                        out.print("selected");
                                    } %>>Μονοκατοικία </option>
                            </select>               
                        </fieldset>
                        <p class="general"></p>
                        <p class="general"></p>
                        <fieldset>
                            <label for="buildDate">Ημερομηνία Κατασκευής <font color="red">*</font>
                            </label>
                            <select name="buildDate" id="buildDate">
                                <%
                                    for (int i = 1900; i <= 2014; i++) {
                                        if (p.getBuildDate() == i) {
                                            out.println("<option selected value=" + i + ">" + i + "</option>");
                                        } else {
                                            out.println("<option value=" + i + ">" + i + "</option>");
                                        }
                                    }
                                %>
                            </select>
                            <label for="renovationDate">Ημερομηνία Ανακαίνισης
                            </label>
                            <select name="renovationDate" id="renovationDate">
                                <option value = "" selected></option>
                                <%
                                    for (int i = 1900; i <= 2014; i++) {
                                        if (p.getRenovationDate() != null) {
                                            if (p.getRenovationDate() == i) {
                                                out.println("<option selected value=" + i + ">" + i + "</option>");
                                            } else {
                                                out.println("<option value=" + i + ">" + i + "</option>");
                                            }
                                        } else {
                                            out.println("<option value=" + i + ">" + i + "</option>");
                                        }
                                    }
                                %>
                            </select>                
                        </fieldset>
                        <br/>
                        <p class="general">
                            <label for="price">Τιμή <font color="red">*</font>
                            </label></p>
                        <input type="text" name="price" id="price" value="<%=p.getPrice().intValue()%>"/>      
                        <br/>    
                        <p class="general">
                            <label for="maintenanceCharges">Έξοδα Συντήρησης <font color="red">*</font>
                            </label></p>
                        <input type="text" name="maintenanceCharges" id="maintenanceCharges" value="<%=p.getMaintenanceCharges().intValue()%>"/> 
                        <p class="general">
                            <label for="sqMeters">Τετραγωνικά Μέτρα <font color="red">*</font>
                            </label></p>
                        <input type="text" name="sqMeters" id="sqMeters" value="<%=p.getSqMeters()%>"/> 
                        <p class="general">
                            <label for="roomsNo">Αριθμός Δωματίων <font color="red">*</font>
                            </label></p>
                        <input type="text" name="roomsNo" id="roomsNo" value="<%=p.getRoomsNo()%>"/>   
                        <p class="general">
                            <label for="floor">Όροφος / Όροφοι <font color="red">*</font>
                            </label></p>
                        <input type="text" name="floor" id="floor" value="<%=p.isIsApartment() ? p.getApFloor() : p.getHFloors()%>"/>             
                        <p class="general">
                            <label for="heatingSystem">Σύστημα Θέρμανσης
                            </label>
                            <select name="heatingSystem" id="heatingSystem">
                                <option value="none"></option>
                                <option value="central_diesel" <%if (p.getHeatingSystem().equals("central_diesel")) {
                                        out.print("selected");
                                    }%> >Κεντρική Θέρμανση Πετρελαίου</option>
                                <option value="atomic_diesel" <%if (p.getHeatingSystem().equals("atomic_diesel")) {
                                        out.print("selected");
                                    }%>>Ατομική Θέρμανση Πετρελαίου</option>
                                <option value="central_gas" <%if (p.getHeatingSystem().equals("central_gas")) {
                                        out.print("selected");
                                    }%>>Κεντρική Θέρμανση Φυσικού Αερίου</option>
                                <option value="atomic_gas" <%if (p.getHeatingSystem().equals("atomic_gas")) {
                                        out.print("selected");
                                    }%>>Ατομική Θέρμανση Φυσικού Αερίου</option>
                                <option value="pelet" <%if (p.getHeatingSystem().equals("pelet")) {
                                        out.print("selected");
                                    }%>>Θέρσμανη με Pelet</option>
                            </select>
                        <fieldset>
                            <label for="airConditioner">Κλιματισμός
                            </label>
                            <input type="checkbox" id="airConditioner" value="1" name="airConditioner" <%if (p.isAirConditioner()) {
                                    out.print("checked");
                                }%> />

                            <label for="parking">Χώρος Στάθμευσης
                            </label>
                            <input type="checkbox" value="1" id="parking" name="parking" <%if (p.isParking()) {
                                    out.print("checked");
                                }%>/>
                            <label for="elevator">Ανελκυστήρας
                            </label>
                            <input type="checkbox" value="1" id="elevator" name="elevator" <%if (p.isElevator()) {
                                    out.print("checked");
                                }%>/>
                        </fieldset>
                        <p class="general">
                            <label for="description">Περιγραφή
                            </label></p>
                        <textarea name="description" rows="5" cols="48" id="description" ><%=p.getDescription()%>
                        </textarea>
                        <p class="general">
                            <label for="address1">Διεύθυνση 1 <font color="red">*</font>
                            </label></p>
                        <input type="text" name="address1" id="address1" onchange="getlatlng()" value="<%=p.getAddress1()%>"/>                
                        <p class="general">
                            <label for="address2">Διεύθυνση 2
                            </label></p>
                        <input type="text" name="address2" id="address2" onchange="getlatlng()" value="<%=p.getAddress2()%>"/>                
                        <p class="general">
                            <label for="address3">Διεύθυνση 3
                            </label></p>
                        <input type="text" name="address3" id="address3" onchange="getlatlng()" value="<%=p.getAddress3()%>"/>             
                        <p class="general">
                            <label for="city">Πόλη <font color="red">*</font>
                            </label></p>
                        <input type="text" name="city" id="city" onchange="getlatlng()" value="<%=p.getCity()%>"/>            
                        <p class="general">
                            <label for="region">Περιοχή <font color="red">*</font>
                            </label></p>
                        <input type="text" onchange="getlatlng()" name="region"  id="region" value="<%=p.getRegion()%>"/>     
                        <p class="general">
                            <label for="postalCode">Ταχυδρομικός Κώδικας <font color="red">*</font>
                            </label></p>
                        <input type="text" onchange="getlatlng()" name="postalCode" id="postalCode" value="<%=p.getPostalCode()%>"/>    
                        <p class="general">
                            <label for="country">Χώρα <font color="red">*</font>
                            </label></p>
                            <% String[] locales = Locale.getISOCountries();%>
                        <select name="country" id="country"  onchange="getlatlng()">
                            <%
                                for (String locale : locales) {
                                    Locale _locale = new Locale("", locale);
                                    if (_locale.getDisplayCountry().equals(p.getCountry())) {
                                        out.println("<option selected value=" + _locale.getDisplayCountry() + ">" + _locale.getDisplayCountry() + "</option>");
                                    } else {
                                        out.println("<option value=" + _locale.getDisplayCountry() + ">" + _locale.getDisplayCountry() + "</option>");
                                    }
                                }
                            %>
                        </select>
                        <script>addproperty(<%=p.getLatitude()%>, <%=p.getLongitude()%>, <%=p.getId().getPropertyId()%>, <%=p.getId().getOwnerUserId()%>,<%=p.isForRent()%>, <%=p.isIsApartment()%>, <%=p.getPrice()%>);</script>
                        <input hidden type="text" id="lat" name="lat" value="<%=p.getLatitude()%>" />
                        <input hidden type="text" id="lng" name="lng" value="<%=p.getLongitude()%>" />
                        <p class="general"></p>
                        <p><input class="buttom" name="submit" id="submit" value="Ολοκλήρωση" type="submit"> </p>	 
                    </form>
                    <p>(<font color="red">*</font> Υποχρεωτικό Πεδίο)</p>
                    <p><a href="setpropertypictures.jsp?uid=<%=user.getUserId()%>&amp;pid=<%=pid%>">Αλλαγή Φωτογραφιών Ιδιοκτησίας</a></p>
                </div>
                <div class="col6 last">
                    <div id="map-canvas" style="height:1000px"></div>
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