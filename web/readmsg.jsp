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
        <title>Find A Residence - Προβολή Μυνήματος Ιδιοκτησίας</title>	
    </head>
    <body>
        <%
            User user = (User) session.getAttribute("user");
            String uid = (String) request.getParameter("uid");
            String mid = (String) request.getParameter("mid");
            String pid = (String) request.getParameter("pid");
            List<Messages> msglst = PropertyIO.getmsgs(Integer.parseInt(uid), Integer.parseInt(pid));
            Messages msg = null;
            for (Messages m : msglst) {
                if (m.getId().getMessageId() == Integer.parseInt(mid)) {
                    msg = m;
                    break;
                }
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
                    </div>
                </div>
            </div>
            <div class="onerow">
                <div class="col12 last" >
                    <h1>Προβολή Μηνύματος</h1> </div> </div>
            <div class="onerow">
                <div class="col12 last" >
                    <p><%=msg.getMessage()%></p>
                    <p>
                        <a href="propertyinfo.jsp?userid=<%=uid%>&amp;pid=<%=pid%>">Επιστροφή</a><br/>
                        <a href="deletemsg?userid=<%=uid%>&amp;pid=<%=pid%>&amp;mid=<%=mid%>">Διαγραφή Μυνήματος</a> 
                    </p>
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