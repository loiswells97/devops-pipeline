package uk.ac.cf.nsa.web.wellbeingportal.wellbeingportal;

import io.github.bonigarcia.wdm.WebDriverManager;
import org.junit.jupiter.api.Test;
import org.junit.runner.RunWith;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.test.context.junit4.SpringRunner;
import org.openqa.selenium.support.ui.Select;

import java.util.concurrent.TimeUnit;

import static org.junit.Assert.*;

@RunWith(SpringRunner.class)
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
public class WebDriverTests {

    private WebDriver webDriver;

    @Value("${local.server.port}")
    private int port;

    @Test
    public void testLoginPageLoads(){
        WebDriverManager.chromedriver().setup();
        ChromeOptions options = new ChromeOptions();
        options.addArguments("--remote-debugging-port=42227");
        options.addArguments("--headless");
//       was this.webDriver =new etc and removed options from the ChromeDriver arguments
//        WebDriver webDriver = new ChromeDriver();
        this.webDriver = new ChromeDriver(options);
        try{
//            was this.webDriver.get etc.
            this.webDriver.get("http://localhost:" + Integer.toString(port) + "/login");
            assertTrue(webDriver.findElements(By.cssSelector("h1")).get(0).getText().contains("Please sign in"));
        } finally{
            webDriver.quit();
        }
    }

//    Check event page loads when you log in
    @Test
    public void testingPageContents() {
        WebDriverManager.chromedriver().setup();
        ChromeOptions options = new ChromeOptions();
        options.addArguments("--remote-debugging-port=42227");
        options.addArguments("--headless");
        this.webDriver = new ChromeDriver(options);
        try{
            this.webDriver.get("http://localhost:" + Integer.toString(port) + "/home");
            this.webDriver.findElement(By.name("username")).sendKeys("1");
            this.webDriver.findElement(By.name("password")).sendKeys("1");
            this.webDriver.findElement(By.className("btn")).click();
            assertTrue(webDriver.findElements(By.cssSelector("h2")).get(0).getText().contains("Events"));
    //        assertTrue(webDriver.findElement(By.id("test")).getText().contains("Events"));

    //        this.webDriver.findElements(By.className("EventDetailsButton")).get(0).click();
    //        assertEquals("block", webDriver.findElements(By.className("tabcontent")).get(0).getCssValue("display"));
    //        for (int i=1; i<webDriver.findElements(By.className("tabcontent")).size();i++){
    //            assertEquals("none", webDriver.findElements(By.className("tabcontent")).get(i).getCssValue("display"));
    //        }
    //
    //        this.webDriver.get("http://localhost:" + Integer.toString(port) + "/Menu");
    //        assertTrue(webDriver.findElement(By.cssSelector("table")).getText().contains("mockDBChips"));
    //
    ////        this.webDriver.get("http://localhost:"+port+"/Admin/DeleteItem");
    ////        assertTrue(webDriver.findElement(By.id("button")).getText().contains("Delete"));
        }finally {
            webDriver.quit();
        }
    }

//Tests that clicking each View Details button opens the relevant tab and that all other tabs are closed.
    @Test
    public void testingPageViewDetailsButton() {
        WebDriverManager.chromedriver().setup();
        ChromeOptions options = new ChromeOptions();
        options.addArguments("--remote-debugging-port=42227");
        options.addArguments("--headless");
        this.webDriver = new ChromeDriver(options);
        try{
            this.webDriver.get("http://localhost:" + Integer.toString(port) + "/home");

            this.webDriver.findElement(By.name("username")).sendKeys("1");
            this.webDriver.findElement(By.name("password")).sendKeys("1");
            this.webDriver.findElement(By.className("btn")).click();

            for (int i=1; i<webDriver.findElements(By.className("tabcontent")).size();i++) {
                this.webDriver.findElements(By.className("eventDetailsButton")).get(i).click();
                assertEquals("block", webDriver.findElements(By.className("tabcontent")).get(i).getCssValue("display"));
                for (int j = 1; j < webDriver.findElements(By.className("tabcontent")).size(); j++) {
                    if (j != i) {
                        assertEquals("none", webDriver.findElements(By.className("tabcontent")).get(j).getCssValue("display"));
                    }
                }
            }
    //        this.webDriver.findElements(By.className("eventDetailsButton")).get(0).click();
    //        assertEquals("block", webDriver.findElements(By.className("tabcontent")).get(0).getCssValue("display"));
    //        for (int i=1; i<webDriver.findElements(By.className("tabcontent")).size();i++){
    //            assertEquals("none", webDriver.findElements(By.className("tabcontent")).get(i).getCssValue("display"));
    //        }
    //
    //        this.webDriver.get("http://localhost:" + Integer.toString(port) + "/Menu");
    //        assertTrue(webDriver.findElement(By.cssSelector("table")).getText().contains("mockDBChips"));
    //
    ////        this.webDriver.get("http://localhost:"+port+"/Admin/DeleteItem");
    ////        assertTrue(webDriver.findElement(By.id("button")).getText().contains("Delete"));
    } finally{
            webDriver.quit();
        }

    }
//    When you click each View Details it changes to say Hide Details and when you click again it changes back to saying
//    View Details with all others remaining View Details
    @Test
    public void wordsChangeOnViewDetailsWhenClicked(){
        WebDriverManager.chromedriver().setup();
        ChromeOptions options = new ChromeOptions();
        options.addArguments("--remote-debugging-port=42227");
        options.addArguments("--headless");
        this.webDriver = new ChromeDriver(options);
        try{
            this.webDriver.get("http://localhost:" + Integer.toString(port) + "/home");

            this.webDriver.findElement(By.name("username")).sendKeys("1");
            this.webDriver.findElement(By.name("password")).sendKeys("1");
            this.webDriver.findElement(By.className("btn")).click();

            for (int i=1; i<webDriver.findElements(By.className("tabcontent")).size();i++) {
                assertEquals("View Details", webDriver.findElements(By.className("eventDetailsButton")).get(i).getText());
                this.webDriver.findElements(By.className("eventDetailsButton")).get(i).click();
                assertEquals("Hide Details", webDriver.findElements(By.className("eventDetailsButton")).get(i).getText());
                for (int j = 1; j < webDriver.findElements(By.className("tabcontent")).size(); j++) {
                    if (j != i) {
                        assertEquals("View Details", webDriver.findElements(By.className("eventDetailsButton")).get(j).getText());
                    }
                }
                this.webDriver.findElements(By.className("eventDetailsButton")).get(i).click();
                for (int j = 1; j < webDriver.findElements(By.className("tabcontent")).size(); j++) {
                    assertEquals("View Details", webDriver.findElements(By.className("eventDetailsButton")).get(j).getText());
                }
            }

        } finally{
            webDriver.quit();
        }

    }

//    When you click View Details for each event and then edit event it opens the relevant edit event form and when
//    you press cancel it closes it
    @Test
    public void openEditEventForm(){
        WebDriverManager.chromedriver().setup();
        ChromeOptions options = new ChromeOptions();
        options.addArguments("--remote-debugging-port=42227");
        options.addArguments("--headless");
        this.webDriver = new ChromeDriver(options);
        try{
            this.webDriver.get("http://localhost:" + Integer.toString(port) + "/home");

            this.webDriver.findElement(By.name("username")).sendKeys("1");
            this.webDriver.findElement(By.name("password")).sendKeys("1");
            this.webDriver.findElement(By.className("btn")).click();

            for (int i=0; i<webDriver.findElements(By.className("tabcontent")).size();i++) {
                this.webDriver.findElements(By.className("eventDetailsButton")).get(i).click();
                assertEquals("none", webDriver.findElements(By.className("editEventForm")).get(i).getCssValue("display"));
                this.webDriver.findElements(By.className("editEventButton")).get(i).click();
                assertEquals("block", webDriver.findElements(By.className("editEventForm")).get(i).getCssValue("display"));
                this.webDriver.findElements(By.className("cancelButton")).get(i).click();
                assertEquals("none", webDriver.findElements(By.className("editEventForm")).get(i).getCssValue("display"));

            }

        } finally{
            webDriver.quit();
        }
    }

//Tests that changing the event type in the edit event form changes the goals for the first and last event on the page,
// with multiple event types selected for each one to show that the functionality is working regardless of initial value
// of the event type.
    @Test
    public void changingEventTypeChangesGoals(){
        WebDriverManager.chromedriver().setup();
        ChromeOptions options = new ChromeOptions();
        options.addArguments("--remote-debugging-port=42227");
        options.addArguments("--headless");
        this.webDriver = new ChromeDriver(options);
        try {
            this.webDriver.get("http://localhost:" + Integer.toString(port) + "/home");

            this.webDriver.findElement(By.name("username")).sendKeys("1");
            this.webDriver.findElement(By.name("password")).sendKeys("1");
            this.webDriver.findElement(By.className("btn")).click();

            this.webDriver.findElements(By.className("eventDetailsButton")).get(0).click();
            this.webDriver.findElements(By.className("editEventButton")).get(0).click();
            Select eventTypeDropdown = new Select(webDriver.findElements(By.className("selectName")).get(0));

            eventTypeDropdown.selectByValue("Cloud Swing");
            assertEquals("Quality Education,  Reduced Inequality", webDriver.findElements(By.name("goals")).get(0).getAttribute("value"));
            eventTypeDropdown.selectByValue("Tightrope Walking");
            assertEquals("Quality Education, Good Health and Well-being,  Reduced Inequality", webDriver.findElements(By.name("goals")).get(0).getAttribute("value"));

            int n=webDriver.findElements(By.className("tabcontent")).size()-1;
            if (n>0){
                this.webDriver.findElements(By.className("eventDetailsButton")).get(n).click();
                this.webDriver.findElements(By.className("editEventButton")).get(n).click();
                Select lastEventTypeDropdown = new Select(webDriver.findElements(By.className("selectName")).get(n));

                lastEventTypeDropdown.selectByValue("Cloud Swing");
                assertEquals("Quality Education,  Reduced Inequality", webDriver.findElements(By.name("goals")).get(n).getAttribute("value"));
                lastEventTypeDropdown.selectByValue("Tightrope Walking");
                assertEquals("Quality Education, Good Health and Well-being,  Reduced Inequality", webDriver.findElements(By.name("goals")).get(n).getAttribute("value"));
            }


        } finally{
            webDriver.quit();
        }

    }


    @Test
    public void clickingInTheGoalsFieldDoesntLetYouType(){
        WebDriverManager.chromedriver().setup();
        ChromeOptions options = new ChromeOptions();
        options.addArguments("--remote-debugging-port=42227");
        options.addArguments("--headless");
        this.webDriver = new ChromeDriver(options);
        try {
            this.webDriver.get("http://localhost:" + Integer.toString(port) + "/home");
            this.webDriver.findElement(By.name("username")).sendKeys("1");
            this.webDriver.findElement(By.name("password")).sendKeys("1");
            this.webDriver.findElement(By.className("btn")).click();

            this.webDriver.findElements(By.className("eventDetailsButton")).get(0).click();
            this.webDriver.findElements(By.className("editEventButton")).get(0).click();
            this.webDriver.findElements(By.name("goals")).get(0).click();
            assertFalse(this.webDriver.findElements(By.name("goals")).get(0).isEnabled());

            int n=webDriver.findElements(By.className("tabcontent")).size()-1;
            if (n>0){
                this.webDriver.findElements(By.className("eventDetailsButton")).get(n).click();
                this.webDriver.findElements(By.className("editEventButton")).get(n).click();
                this.webDriver.findElements(By.name("goals")).get(n).click();
                assertFalse(this.webDriver.findElements(By.name("goals")).get(n).isEnabled());
            }

        }finally{
            webDriver.quit();
        }

    }




}
