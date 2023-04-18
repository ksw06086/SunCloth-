package com.spring.project.dto;

import java.util.Collection;

import lombok.Getter;
import lombok.Setter;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;

//  User 클래스는 스프링 시큐리티에 내장된 추상클래스로, 사용자 상세정보를 담는 그릇 역할을 하는 클래스이다.
//  User 클래스는 추상클래스이므로 상속받아 추상메소드를 오버라이드 한다.
@Getter
@Setter
public class UserDTO extends User{

	private String id;
	
    // 두 생성자 중 첫번째 선택, 마지막 배개변수에 String userid 추가
	// super는 부모 User 클래스
	public UserDTO(String username, String password, boolean enabled, boolean accountNonExpired,
				   boolean credentialsNonExpired, boolean accountNonLocked,
				   Collection<? extends GrantedAuthority> authorities, String id) {
		super(username, password, enabled, accountNonExpired, credentialsNonExpired, accountNonLocked, authorities);
		
		this.id = id;
	}

	@Override
	public String toString() {
		return "UserDTO [id=" + id + "]";
	}
	
	

}
