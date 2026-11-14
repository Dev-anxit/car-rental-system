<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Concierge | Apex Drive</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Outfit:wght@600;700;800&display=swap" rel="stylesheet">
</head>
<body>

    <jsp:include page="/WEB-INF/views/common/navbar.jsp" />

    <div class="container" style="padding-top: 50px; padding-bottom: 80px;">
        <jsp:include page="/WEB-INF/views/common/alerts.jsp" />

        <div style="display: grid; grid-template-columns: 1fr 1.2fr; gap: 48px; max-width: 1060px; margin: 0 auto;">
            <div>
                <span class="hero-tag">★ 24/7 Concierge Support</span>
                <h1 style="font-size: 2.3rem; margin: 12px 0 16px;">We're Here For Your Journey</h1>
                <p style="color: var(--text-secondary); line-height: 1.7; margin-bottom: 30px;">
                    Have questions regarding custom rental durations, long-term fleet leases, or bespoke airport transfers? Connect with our dedicated fleet team.
                </p>

                <div style="display: flex; flex-direction: column; gap: 20px;">
                    <div style="display: flex; gap: 16px; align-items: flex-start;">
                        <div class="feature-icon" style="margin: 0; width: 44px; height: 44px;">
                            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"></path><circle cx="12" cy="10" r="3"></circle></svg>
                        </div>
                        <div>
                            <h4 style="font-size: 1rem;">Flagship Lounge</h4>
                            <p style="color: var(--text-secondary); font-size: 0.9rem;">100 Auto Boulevard, Suite 500, New York, NY</p>
                        </div>
                    </div>

                    <div style="display: flex; gap: 16px; align-items: flex-start;">
                        <div class="feature-icon" style="margin: 0; width: 44px; height: 44px;">
                            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"></path></svg>
                        </div>
                        <div>
                            <h4 style="font-size: 1rem;">Phone Inquiries</h4>
                            <p style="color: var(--text-secondary); font-size: 0.9rem;">+1 (800) 555-APEX / +1 (555) 019-2834</p>
                        </div>
                    </div>

                    <div style="display: flex; gap: 16px; align-items: flex-start;">
                        <div class="feature-icon" style="margin: 0; width: 44px; height: 44px;">
                            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"></path><polyline points="22,6 12,13 2,6"></polyline></svg>
                        </div>
                        <div>
                            <h4 style="font-size: 1rem;">Direct Email</h4>
                            <p style="color: var(--text-secondary); font-size: 0.9rem;">concierge@apexdrive.com</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Contact Form -->
            <div style="background: var(--bg-surface); border: 1px solid var(--border-color); border-radius: var(--radius-lg); padding: 36px;">
                <h3 style="font-size: 1.4rem; margin-bottom: 20px;">Send Us a Message</h3>
                <form action="${pageContext.request.contextPath}/contact" method="POST">
                    <div class="form-group" style="margin-bottom: 16px;">
                        <label for="name">Your Name</label>
                        <input type="text" id="name" name="name" class="form-control" required placeholder="John Doe">
                    </div>

                    <div class="form-group" style="margin-bottom: 16px;">
                        <label for="email">Email Address</label>
                        <input type="email" id="email" name="email" class="form-control" required placeholder="john@example.com">
                    </div>

                    <div class="form-group" style="margin-bottom: 16px;">
                        <label for="subject">Subject</label>
                        <input type="text" id="subject" name="subject" class="form-control" required placeholder="Booking inquiry / custom event">
                    </div>

                    <div class="form-group" style="margin-bottom: 24px;">
                        <label for="message">Message</label>
                        <textarea id="message" name="message" class="form-control" rows="4" required placeholder="Tell us about your requirements..."></textarea>
                    </div>

                    <button type="submit" class="btn btn-primary btn-block" style="padding: 14px;">
                        Send Message
                    </button>
                </form>
            </div>
        </div>
    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

</body>
</html>

