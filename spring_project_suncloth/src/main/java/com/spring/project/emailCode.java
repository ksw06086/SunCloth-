package com.spring.project;

/* 네이버 메일 연동 관련 함수 나중에 써먹을 것 */
public class emailCode {
    // bean 설정을 했을 경우
    /*public void sendEmail() throws Exception {
        JavaMailSenderImpl  mailSender = (JavaMailSenderImpl)ctx.getBean("mailSender");

        // 메일 내용
        String subject = "메일 발송시 제목";
        String content = "메일 발송시 내용";

        // 보내는 사람
        String frm = "보내는 사람";

        // 받는 사람
        String[] to = new String[2];
        to[0] = "받는 사람 이메일";
        to[1] = "받는 사람 이메일";

        try {
            // 메일 내용 넣을 객체와, 이를 도와주는 Helper 객체 생성
            MimeMessage mail = mailSender.createMimeMessage();
            MimeMessageHelper mailHelper = new MimeMessageHelper(mail, "UTF-8");

            // 메일 내용을 채워줌
            mailHelper.setFrom(from);	// 보내는 사람 셋팅
            mailHelper.setTo(to);		// 받는 사람 셋팅
            mailHelper.setSubject(subject);	// 제목 셋팅
            mailHelper.setText(content);	// 내용 셋팅

            // 메일 전송
            mailSender.send(mail);
        } catch(Exception e) {
            e.printStackTrace();
        }
    }*/

    // bean 설정을 안했을 경우
    /*public void sendEmail() throws Exception {
        // 메일 관련 정보
        String host = "smtp.naver.com";
        String username = "SMTP 허용 이메일 계정";
        String password = "비밀번호";
        int port = 465;

        // 메일 내용
        String subject = "메일 발송시 제목";
        String content = "메일 발송시 내용";

        Properties props = System.getProperties();
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", port);
        props.put("mail.smtp.auth", true);
        props.put("mail.smtp.ssl.enable", true);
        props.put("mail.smtp.ssl.trust", host);

        Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
            String user = username;
            String pass = password;
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(user, pass);
            }
        });
        session.setDebug(true);

        // 보내는 사람
        String frm = "보내는 사람";

        // 받는 사람
        String to = "받는 사람 이메일";

        try {
            // 메일 내용 넣을 객체와, 이를 도와주는 Helper 객체 생성
            MimeMessage mimeMessage = new MimeMessage(session);

            mimeMessage.setFrom(new InternetAddress(from)); // 보내는 사람 세팅
            mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(to)); // 받는 사람 세팅
            mimeMessage.setSubject(subject);	// 제목 세팅
            mimeMessage.setText(content);	// 내용 세팅

            // 메일 전송
            mailSender.send(mail);
        } catch(Exception e) {
            e.printStackTrace();
        }
    }*/
}
