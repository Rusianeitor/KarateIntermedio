import com.intuit.karate.junit5.Karate;

public class SuperRunner {

    @Karate.Test
    Karate ejecutor() {
        //return Karate.run("user-get").tags("~@ignore").relativeTo(getClass());
        return Karate.run("classpath:apiREST/rest.feature").tags("~@ignore");
        //return Karate.run("classpath:apiSOAP/soap.feature").tags("~@ignore");
        //return Karate.run("classpath:apiGRAPHQL/graphql.feature").tags("~@ignore");
    }
}
