package uk.ac.cf.nsa.web.wellbeingportal.wellbeingportal;

import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.junit.jupiter.api.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;
import uk.ac.cf.nsa.web.wellbeingportal.wellbeingportal.DTO.EventDTO;
import uk.ac.cf.nsa.web.wellbeingportal.wellbeingportal.DTO.FrameDTO;
import uk.ac.cf.nsa.web.wellbeingportal.wellbeingportal.DTO.OrganisationDTO;
import uk.ac.cf.nsa.web.wellbeingportal.wellbeingportal.DTO.VolunteersDTO;
import uk.ac.cf.nsa.web.wellbeingportal.wellbeingportal.controller.EventController;
import uk.ac.cf.nsa.web.wellbeingportal.wellbeingportal.form.EditEventForm;
import uk.ac.cf.nsa.web.wellbeingportal.wellbeingportal.repository.EventRepository;
import uk.ac.cf.nsa.web.wellbeingportal.wellbeingportal.repository.FrameRepository;
import uk.ac.cf.nsa.web.wellbeingportal.wellbeingportal.repository.OrganisationRepository;
import uk.ac.cf.nsa.web.wellbeingportal.wellbeingportal.repository.VolunteersRepository;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.BDDMockito.given;
import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.user;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;
import static org.hamcrest.Matchers.containsString;

@SpringBootTest
@AutoConfigureMockMvc
//@RunWith(SpringRunner.class)
//@WebMvcTest(EventController.class)
public class LightweightMockMVCSecurityTests {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private EventRepository eventRepo;

    @MockBean
    private VolunteersRepository volunteersRepo;

    @MockBean
    private FrameRepository frameRepo;

    @MockBean
    private OrganisationRepository organisationRepo;

    @Test
    public void getHomePageUnauthorised() throws Exception{

        this.mockMvc.perform(get("/home"))
                .andDo(print()).andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("http://localhost/login"));
    }

    @Test

    public void getHomePageAuthorised() throws Exception{

        given(this.eventRepo.findAllEvents("1")).willReturn(new ArrayList());
        given(this.organisationRepo.selectOrganisation("1")).willReturn(new ArrayList());
        given(this.frameRepo.findNoneRepeatFrames("1")).willReturn(new ArrayList());

        this.mockMvc.perform(get("/home")
                .with(user("1").password("1").roles("USER")))
                .andDo(print())
                .andExpect(status().isOk())
                .andExpect(content().string(containsString("Events")));
    }



//    Tests that a single mocked event appears on the home page
    @Test

    public void showEvent() throws Exception{
        Date date = new Date();
        EventDTO eventDTO = new EventDTO(date, 3, 1, "Newport",
                "children, exercise, training", "Football Coaching");

        given(this.eventRepo.findAllEvents("1")).willReturn(Arrays.asList(eventDTO));
        given(this.organisationRepo.selectOrganisation("1")).willReturn(new ArrayList());
        given(this.frameRepo.findNoneRepeatFrames("1")).willReturn(new ArrayList());
        given(this.volunteersRepo.filterVoluteersByEvent(1)).willReturn(new ArrayList());
        given(this.frameRepo.getGoalsByFrameName("Football Coaching", "1")).willReturn("");

        this.mockMvc.perform(get("/home")
                .with(user("1").password("1").roles("USER")))
                .andDo(print())
                .andExpect(status().isOk())
                .andExpect(content().string(containsString("Football Coaching")));
    }


//    Tests that multiple mocked events appear on the home page
    @Test

    public void showMultipleEvents() throws Exception{
        Date date = new Date();
        EventDTO eventDTO1 = new EventDTO(date, 3, 1, "Newport",
                "children, exercise, training", "Football Coaching");
        EventDTO eventDTO2 = new EventDTO(date, 3, 1, "Newport",
                "children, exercise, match", "Football Refereeing");

//        OrganisationDTO organisationDTO = new OrganisationDTO(1, "", "","","","",0);

        given(this.eventRepo.findAllEvents("1")).willReturn(Arrays.asList(eventDTO1, eventDTO2));
        given(this.organisationRepo.selectOrganisation("1")).willReturn(new ArrayList());
        given(this.frameRepo.findNoneRepeatFrames("1")).willReturn(new ArrayList());
        given(this.volunteersRepo.filterVoluteersByEvent(1)).willReturn(new ArrayList());
        given(this.frameRepo.getGoalsByFrameName("Football Coaching", "1")).willReturn("");

        this.mockMvc.perform(get("/home")
                .with(user("1").password("1").roles("USER")))
                .andDo(print())
                .andExpect(status().isOk())
                .andExpect(content().string(containsString("Football Coaching")))
                .andExpect(content().string(containsString("Football Refereeing")));
    }

//    Tests that mocked frame names appear in a dropdown list
    @Test
    public void listFrameNames() throws Exception{
        Date date = new Date();
        EventDTO eventDTO = new EventDTO(date, 3, 1, "Newport",
                "children, exercise, training", "Football Coaching");

        FrameDTO frame1 = new FrameDTO();
        frame1.setName("event1");

        FrameDTO frame2 = new FrameDTO();
        frame2.setName("event2");

        String dropdownList="<select id=\"description\" class=\"form-control selectName\" >\n" +
                "                                        <option value=\"Football Coaching\">Football Coaching</option>\n" +
                "                                        <option value=\"event1\">event1</option>\n" +
                "                                        <option value=\"event2\">event2</option>\n" +
                "                                    </select>";


        given(this.eventRepo.findAllEvents("1")).willReturn(Arrays.asList(eventDTO));
        given(this.organisationRepo.selectOrganisation("1")).willReturn(new ArrayList());
        given(this.frameRepo.findNoneRepeatFrames("1")).willReturn(Arrays.asList(frame1, frame2));
        given(this.volunteersRepo.filterVoluteersByEvent(1)).willReturn(new ArrayList());
        given(this.frameRepo.getGoalsByFrameName("Football Coaching", "1")).willReturn("");

        this.mockMvc.perform(get("/home")
                .with(user("1").password("1").roles("USER")))
                .andDo(print())
                .andExpect(status().isOk())
                .andExpect(content().string(containsString(dropdownList)));

    }
    //    Adapted from https://stackoverflow.com/questions/36568518/testing-form-posts-through-mockmvc
//    Checks that sending a post request to /editEvent when not logged in redirects to /login
    @DirtiesContext
    @Test
    public void submitEditEventFormUnauthorised() throws Exception {
        this.mockMvc.perform(post("/editEvent").contentType(MediaType.APPLICATION_FORM_URLENCODED).content(EntityUtils.toString(new UrlEncodedFormEntity(Arrays.asList(
                new BasicNameValuePair("Date", "2022-06-25"),
                new BasicNameValuePair("providerID", "1"),
                new BasicNameValuePair("activityID", "1"),
                new BasicNameValuePair("location", "Newport"),
                new BasicNameValuePair("keywords", "fun"),
                new BasicNameValuePair("description", "Football")
        ))))).andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("http://localhost/login"));
    }
}
