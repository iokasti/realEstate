<%@page import="entities.User"%>
<%@page import="java.util.Locale"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">	
        <link rel="stylesheet" type="text/css" href="css/style.css">
        <script src="javascript/scripts.js" type="text/javascript"></script>
        <title>Find A Residence - Αλλαγή Κωδικού</title>	
    </head>
    <body>
        <% User user = (User) session.getAttribute("user");
            if (user == null) {
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
                            <li><a href='#'>Καταχώρηση Ιδιοκτησίας</a></li>
                                <%}%>
                            <li><a href='search.jsp'>Αναζήτηση Ιδιοκτησιών</a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="onerow">
                <div class="col12 last">
                    <h1>Αλλαγή Κωδικού</h1>
                    <form id="general-form" name="form" method="post" action="changepassword" onsubmit="return validateChangePasswordForm()">
                        <p class="general">
                            <label>Παλιός Κωδικός <font color="red">*</font>
                            </label></p>
                        <input type="password" name="oldpassword"  />            
                        <p class="general">
                            <label>Νέος Κωδικός <font color="red">*</font>
                            </label></p>
                        <input type="password" name="newpassword"  />

                        <p class="general">
                            <label>Επιβεβαίωση Νέου Κωδικού <font color="red">*</font>
                            </label></p>
                        <input type="password" name="renewpassword"  />
                        <p><input class="buttom" name="submit" id="submit" value="Ολοκλήρωση" type="submit"> </p>  
                    </form>
                    <p>(<font color="red">*</font> Υποχρεωτικό Πεδίο)</p>
                        <%String message = (String) request.getAttribute("status");
                        if (message != null && message.equals("success")) {%>
                    <p style="color: green">Ο Κωδικός άλλαξε με επιτυχία!</p>
                    <%} else if (message != null && message.equals("fail")) {%>
                    <p style="color: red">Εισάγατε λάθος κωδικό. Παρακαλώ ξαναπροσπαθήστε.</p>
                    <%}%>
                    <p><a href="editprofile.jsp">Επιστροφή</a></p>
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
