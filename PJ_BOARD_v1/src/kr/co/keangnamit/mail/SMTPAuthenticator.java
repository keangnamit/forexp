package kr.co.keangnamit.mail;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

/**
 * @author Ray
 * 
 */
public class SMTPAuthenticator extends Authenticator {
	private String username = "onesum@kne.co.kr";
	private String password = "thfktl0";
	protected PasswordAuthentication getPasswordAuthentication() {
		// String username = "nustaerg@gmail.com"; // gmail 사용자;
		// String password = "wjdalstl0"; // 패스워드;
		//String username = "onesum@kne.co.kr"; // gmail 사용자;
		//String password = "thfktl0"; // 패스워드;
		String username = this.getUsername();
		String password = this.getPassword();
		return new PasswordAuthentication(username, password);
	}
	
	public void setUsername(String value){
		this.username = value;
	}
	public void setPassword(String value){
		this.password = value;
	}

	public String getUsername(){
		return this.username;
	}
	public String getPassword(){
		return this.password;
	}

}
