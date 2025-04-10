<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script src="https://cdn.botpress.cloud/webchat/v2.3/inject.js"></script>
</head>
<body>
<script>
  window.addEventListener("load", function () {
    window.botpress.init({
      botId: "ca7cf123-5211-432b-95db-10545f090a33",
      clientId: "ca7cf123-5211-432b-95db-10545f090a33",
      hostUrl: "https://cdn.botpress.cloud/webchat/v2",
      messagingUrl: "https://messaging.botpress.cloud",
      botName: "Asistente Virtual",
      enableConversationDeletion: true,
      stylesheet: "https://cdn.botpress.cloud/webchat/v2.3/themes/default.css",
      showPoweredBy: false
    });
  });
</script>

</body>
</html>
