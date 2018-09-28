package com.chitfund.security.jwt.controller;

import java.util.Objects;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.chitfund.payload.ApiResponse;
import com.chitfund.security.AuthenticationException;
import com.chitfund.security.jwt.JwtTokenUtil;
import com.chitfund.security.payload.JwtAuthenticationResponse;
import com.chitfund.security.payload.SignInRequest;
import com.chitfund.security.payload.SignUpRequest;
import com.chitfund.service.UserService;

@RestController
@ConditionalOnProperty(value = "security.jwt.enable", havingValue = "true", matchIfMissing = false)
public class AuthenticationRestController {

	private final static Logger _LOGGER = LogManager.getLogger(AuthenticationRestController.class);
	
    @Autowired
    private AuthenticationManager authenticationManager;

    @Autowired
    private JwtTokenUtil jwtTokenUtil;

    @Autowired
    private UserService userService;

    @RequestMapping(value = "/Services/auth/signin", method = RequestMethod.POST)
    public ResponseEntity<?> signin(@Valid @RequestBody SignInRequest authenticationRequest) throws AuthenticationException {

        authenticate(authenticationRequest.getUsername(), authenticationRequest.getPassword());

        // Reload password post-security so we can generate the token
        final UserDetails userDetails = userService.loadUserByUsername(authenticationRequest.getUsername());
        final String token = jwtTokenUtil.generateToken(userDetails);

        // Return the token
        return ResponseEntity.ok(new JwtAuthenticationResponse(token));
    }
    
    @RequestMapping(value = "/Services/auth/signup", method = RequestMethod.POST)
    public ResponseEntity<?> signup(@Valid @RequestBody SignUpRequest authenticationRequest) throws AuthenticationException {

        // Reload password post-security so we can generate the token
        ApiResponse response = userService.signup(authenticationRequest);
        
        // Return the token
        return ResponseEntity.ok(response);
    }

    @RequestMapping(value = "/Services/auth/refresh", method = RequestMethod.GET)
    public ResponseEntity<?> refreshAndGetAuthenticationToken(HttpServletRequest request) {
        String authToken = request.getHeader("Authorization");
        final String token = authToken.substring(7);
        if (jwtTokenUtil.canTokenBeRefreshed(token)) {
            String refreshedToken = jwtTokenUtil.refreshToken(token);
            return ResponseEntity.ok(new JwtAuthenticationResponse(refreshedToken));
        } else {
            return ResponseEntity.badRequest().body(null);
        }
    }

    @ExceptionHandler({AuthenticationException.class})
    public ResponseEntity<String> handleAuthenticationException(AuthenticationException e) {
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(e.getMessage());
    }

    /**
     * Authenticates the user. If something is wrong, an {@link AuthenticationException} will be thrown
     */
    private void authenticate(String username, String password) {
        Objects.requireNonNull(username);
        Objects.requireNonNull(password);

        try {
            authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(username, password));
        } catch (DisabledException e) {
        	_LOGGER.info("User is disabled!", e);
            throw new AuthenticationException("User is disabled!", e);
        } catch (BadCredentialsException e) {
        	_LOGGER.info("Bad credentials!", e);
            throw new AuthenticationException("Bad credentials!", e);
        }
    }
}