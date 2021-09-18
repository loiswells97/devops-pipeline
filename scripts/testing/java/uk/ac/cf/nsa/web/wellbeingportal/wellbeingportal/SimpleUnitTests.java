package uk.ac.cf.nsa.web.wellbeingportal.wellbeingportal;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import uk.ac.cf.nsa.web.wellbeingportal.wellbeingportal.DTO.EventDTO;
import uk.ac.cf.nsa.web.wellbeingportal.wellbeingportal.controller.FrameController;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertSame;

import java.util.Date;

@SpringBootTest
public class SimpleUnitTests {

//    Tests constructor and getters for the EventDTO class work
    @Test
    void eventDTOTest(){
    Date date = new Date();
    EventDTO eventDTO = new EventDTO(date, 3, 1, "Newport",
            "children, exercise, training", "Football Coaching");
    assertEquals(eventDTO.getDate(), date);
    assertEquals(eventDTO.getDateString(), date.toString());
    assertEquals(eventDTO.getProviderID(), 3);
    assertEquals(eventDTO.getActivityID(), 1);
    assertEquals(eventDTO.getLocation(), "Newport");
    assertEquals(eventDTO.getKeywords(), "children, exercise, training");
    assertEquals(eventDTO.getDescription(), "Football Coaching");

}

    @Test
    public void whenRemoveSpacesThenReplaceWithUnderscore(){
        assertEquals("Time_spent_planting_trees", FrameController.replaceSpaces("Time spent planting trees"));
    }

    @Test
    public void whenRemoveSpacesFromStringWithNoSpacesThenReturnOriginalString(){
        assertEquals("TimeSpentPlantingTrees", FrameController.replaceSpaces("TimeSpentPlantingTrees"));
    }


    @Test
    public void whenRemoveZeroUnderscoresThenDoNothing(){
        assertSame("TimeSpentPlantingTrees", FrameController.replaceUnderscores("TimeSpentPlantingTrees"));
    }

    @Test
    public void whenRemoveUnderscoresThenReplaceWithSpaces(){
        assertEquals("Time spent planting trees",FrameController.replaceUnderscores("Time_spent_planting_trees"));
    }

    @Test
    public void whenRemoveAndReplaceSpacesThenDoNothing(){
        assertEquals("Time spent planting trees",FrameController.replaceUnderscores(FrameController.replaceSpaces("Time spent planting trees")));
    }


}
