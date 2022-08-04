package test.springboot.vscode.testvscode.web;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.RequiredArgsConstructor;
import test.springboot.vscode.testvscode.service.HelloWorldService;

@RestController
@RequiredArgsConstructor
public class HelloWorldController {
    private final HelloWorldService helloService;

    @GetMapping("/hello")
    public String hello() {
        return helloService.hello();
    }
    
}
