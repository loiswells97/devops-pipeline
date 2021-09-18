//package uk.ac.cf.nsa.web.wellbeingportal.wellbeingportal;
//
//import org.junit.jupiter.api.Test;
//import org.springframework.boot.test.context.SpringBootTest;
//import uk.ac.cf.nsa.web.wellbeingportal.wellbeingportal.controller.EventController;
//import uk.ac.cf.nsa.web.wellbeingportal.wellbeingportal.controller.FrameController;
//
//import static org.junit.jupiter.api.Assertions.*;
//import static org.junit.jupiter.api.Assertions.assertEquals;
//
//@SpringBootTest
//class WellbeingPortalApplicationTests {
//
//
//    @Test
//    public void whenRemoveSpacesThenReplaceWithUnderscore(){
//        assertEquals("Time_spent_planting_trees",FrameController.replaceSpaces("Time spent planting trees"));
//    }
//
//    @Test
//    public void whenRemoveSpacesFromStringWithNoSpacesThenReturnOriginalString(){
//        assertEquals("TimeSpentPlantingTrees", FrameController.replaceSpaces("TimeSpentPlantingTrees"));
//    }
//
//
//    @Test
//    public void whenRemoveZeroUnderscoresThenDoNothing(){
//        assertSame("TimeSpentPlantingTrees", FrameController.replaceUnderscores("TimeSpentPlantingTrees"));
//    }
//
//    @Test
//    public void whenRemoveUnderscoresThenReplaceWithSpaces(){
//        assertEquals("Time spent planting trees",FrameController.replaceUnderscores("Time_spent_planting_trees"));
//    }
//
//    @Test
//    public void whenRemoveAndReplaceSpacesThenDoNothing(){
//        assertEquals("Time spent planting trees",FrameController.replaceUnderscores(FrameController.replaceSpaces("Time spent planting trees")));
//    }
//
//}
