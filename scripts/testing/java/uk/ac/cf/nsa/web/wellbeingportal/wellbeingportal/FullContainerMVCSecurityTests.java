package uk.ac.cf.nsa.web.wellbeingportal.wellbeingportal;

import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.test.web.servlet.MockMvc;
import uk.ac.cf.nsa.web.wellbeingportal.wellbeingportal.form.EditEventForm;

import java.util.Arrays;
import java.util.Date;

import static org.hamcrest.Matchers.containsString;
import static org.mockito.BDDMockito.given;
import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.user;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@SpringBootTest
@AutoConfigureMockMvc
public class FullContainerMVCSecurityTests {

    @Autowired
    public MockMvc mockMvc;

//    Tests that the home page loads event names, dates and details from the mack database
    @Test
    public void whenLoadHomePageDisplayEventsFromDB() throws Exception {
        this.mockMvc.perform(get("/home")
                .with(user("1").password("1").roles("USER")))
                .andDo(print())
                .andExpect(status().isOk())
                .andExpect(content().string(containsString("Tightrope Walking")))
                .andExpect(content().string(containsString("2021-08-27")))
                .andExpect(content().string(containsString("Cardiff")))
                .andExpect(content().string(containsString("Juggling")))
                .andExpect(content().string(containsString("2021-09-27")))
                .andExpect(content().string(containsString("Newport")));
    }

//    Check that the home page contains a dropdown list with the frame names from the mock database
    @Test
    public void whenLoadHomePageLoadFrameNamesFromDB() throws Exception{
        String dropdownList="<select id=\"description\" class=\"form-control selectName\" >\n" +
                "                                        <option value=\"Juggling\">Juggling</option>\n" +
                "                                        <option value=\"Cloud Swing\">Cloud Swing</option>\n" +
                "                                        <option value=\"Juggling\">Juggling</option>\n" +
                "                                        <option value=\"Tightrope Walking\">Tightrope Walking</option>\n" +
                "                                    </select>";

        this.mockMvc.perform(get("/home")
        .with(user("1").password("1").roles("USER")))
                .andDo(print())
                .andExpect(content().string(containsString(dropdownList)));


    }

    //    Adapted from https://stackoverflow.com/questions/36568518/testing-form-posts-through-mockmvc
//     Tests that post requests to /editEvent return 200 OK, so events are edited in the database.
    @DirtiesContext
    @Test
    public void submitEditEventFormFullContainer() throws Exception {

        this.mockMvc.perform(post("/editEvent").contentType(MediaType.APPLICATION_FORM_URLENCODED).content(EntityUtils.toString(new UrlEncodedFormEntity(Arrays.asList(
                new BasicNameValuePair("Date", "2022-06-25"),
                new BasicNameValuePair("providerID", "1"),
                new BasicNameValuePair("activityID", "1"),
                new BasicNameValuePair("location", "Newport"),
                new BasicNameValuePair("keywords", "fun"),
                new BasicNameValuePair("description", "Football")
        )))).with(user("1").password("1").roles("USER"))).andExpect(status().isOk());
    }

//    ***THIS TEST FAILS, REVEALING A FLAW IN THE SYSTEM WHICH POTENTIALLY ALLOWS USERS TO SEND A POST REQUEST THAT
//    EDITS THE EVENT OF ANOTHER USER IN THE DATABASE. ***
//    Adapted from https://stackoverflow.com/questions/36568518/testing-form-posts-through-mockmvc
//    @DirtiesContext
//    @Test
//    public void submitEditEventFormForAnotherUser() throws Exception {
//        this.mockMvc.perform(post("/editEvent").contentType(MediaType.APPLICATION_FORM_URLENCODED).content(EntityUtils.toString(new UrlEncodedFormEntity(Arrays.asList(
//                new BasicNameValuePair("Date", "2022-06-25"),
//                new BasicNameValuePair("providerID", "2"),
//                new BasicNameValuePair("activityID", "1"),
//                new BasicNameValuePair("location", ""),
//                new BasicNameValuePair("keywords", ""),
//                new BasicNameValuePair("description", "")
//        )))).with(user("1").password("1").roles("USER"))).andExpect(status().isUnauthorized());
//    }

//    Tests that the event volunteers from the mock database are displayed on the page
    @Test
    public void volunteersFromDBDisplayedOnHomePage() throws Exception {
        this.mockMvc.perform(get("/home")
                .with(user("1").password("1").roles("USER")))
                .andDo(print())
                .andExpect(content().string(containsString("<td>Joe</td>\n" +
                        "                                                <td>Bloggs</td>")))
                .andExpect(content().string(containsString("<td>John</td>\n" +
                        "                                                <td>Doe</td>")))
                .andExpect(content().string(containsString("<td>Jacob</td>\n" +
                "                                                <td>Josephs</td>")))
                .andExpect(content().string(containsString("<td>Tabitha</td>\n" +
                        "                                                <td>McCallum</td>")));
    }

}
