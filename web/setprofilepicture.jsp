<%@page import="entities.User"%>
<%@page import="java.util.Locale"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">	
        <link rel="stylesheet" type="text/css" href="css/style.css">
        <script src="javascript/scripts.js" type="text/javascript"></script>
        <title>Find A Residence - Αλλαγή Φωτογραφίας Χρήστη</title>	
    </head>
    <body>
        <div class="onepcssgrid-1200">
            <div class="onerow">
                <div class="col5">
                    <a href="index.jsp"><img src="images/far.png" alt="logo"/></a>
                </div>
                <div class="col7 last">
                    <% User user = (User) session.getAttribute("user");
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
                                    <li><a href='myproperties.jsp'>Οι Ιδιοκτησίες Μου</a></li>
                                    <li><a href='editprofile.jsp'>Επεξεργασία Προφίλ</a></li>
                                    <li><a href='logout.jsp'>Έξοδος</a></li>
                                </ul></li>
                                <%if (user.isLessor() || user.isSeller()) {%>
                            <li><a href='#'>Καταχώρηση Ιδιοκτησίας</a></li>
                                <%}%>
                            <li><a href='search.jsp'>Αναζήτηση Ιδιοκτησιών</a></li>
                        </ul>
                    </div>
                    <%}%>
                </div>
            </div>
            <div class="onerow">
                <div class="col12 last">
                    <h1>Αλλαγή Φωτογραφίας Χρήστη</h1>
                    <% if (user != null) {%>
                    <img id="pp" src="images/profilepictures/profile_picture_<%= user.getUserId()%>.jpg" alt=""/>
                    <%}%>
                </div>
            </div>
            <div class="onerow">
                <div class="col12 last">
                    <form id="general-form" action="setprofilepicture" method="POST" enctype="multipart/form-data" onsubmit="return validateImage(this)">
                        <%
                            String username;
                            if (user == null) {
                                username = (String) request.getAttribute("username");
                                if (username == null) {
                                    response.sendRedirect("index.jsp");
                                }
                            } else {
                                username = user.getUsername();
                            }
                            out.println("<input hidden type=\"text\" name=\"username\" value=\"" + username + "\"/>");%>
                        <p class="general"><label for="picture">Επιλογή Αρχείου <font color="red">(μέγιστο μέγεθος: 1 megabyte)</font>
                            </label></p>
                        <input id="picture" type="file" name="picture" />
                        <p><input class="buttom" name="submit" id="submit" value="Ολοκλήρωση" type="submit"> </p>	 
                    </form>
                    <%if (user == null) {%>
                    <p><a href="pending.jsp">Παράκαμψη</a></p>	 
                    <% } else { %>
                    <p><a href="editprofile.jsp">Επιστροφή</a></p><%}%>	 
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
