import * as nodemailer from 'nodemailer';
export class Email {
    private emailAdmin: string = 'anhh4533@gmail.com';
    private passwordAdmin: string = 'hoanganH123@';
    private emailTo: string;
    private displayNameTo: string;
    private transporter: any;
    mailOptions: any;

    constructor(email: string, displayName: string) {
        this.emailTo = email;
        this.displayNameTo = displayName;
        this.initEmailSystem(this.emailAdmin, this.passwordAdmin);
    }

    private initEmailSystem(emailAdmin: string, passwordAdmin: string): void {
        this.transporter = nodemailer.createTransport({
            service: 'gmail',
            auth: {
                user: emailAdmin,
                pass: passwordAdmin
            }
        });
    }

    private initEmailOptions(emailAdmin: string, emailTo: string, displayNameTo: string): any {
        return this.mailOptions = {
            from: emailAdmin,
            to: emailTo,
            subject: 'Send Welcome Email',
            text:
                `Xin chào ${displayNameTo},
                Chào mừng tới với Guess The Flag game do Hoang Anh đã tạo ra. Rất mong bạn có thời gian vui vẻ khi trải nghiệm app của chúng tôi
                `
        };
    }

    public sendEmail(): void {
        let options: any = this.initEmailOptions(this.emailAdmin, this.emailTo, this.displayNameTo);
        this.transporter.sendMail(options, function (error: any, info: any) {
            if (error) {
                console.log(error);
            } else {
                console.log('Email sent: ' + info.response);
            }
        });
    }
}