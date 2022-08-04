package test.springboot.vscode.testvscode.service;

import org.springframework.stereotype.Service;

@Service
public class HelloWorldService {
    public String hello() {
        return "Hello, World!!!";
    }
    
}
