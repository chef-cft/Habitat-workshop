package io.chef.nationalparks.rest;

//import com.mongodb.BasicDBObject;
//import com.mongodb.client.MongoCollection;
//import com.mongodb.client.MongoCursor;
//import com.mongodb.client.MongoDatabase;
import io.chef.nationalparks.domain.NationalPark;
//import io.chef.nationalparks.mongo.DBConnection;
import org.json.JSONArray;
import org.json.JSONObject;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import java.util.ArrayList;
import java.util.List;
import java.util.List;
import org.apache.commons.io.FileUtils;
import java.io.File;
import java.math.BigDecimal;
import java.lang.Float;

@Path("/parks")
public class NationalParksResource
{    

    private static List<NationalPark> CACHE = null;

    private List<NationalPark> Load() throws Exception
    {       
        if(CACHE != null) return CACHE;

        List<NationalPark> ret = new ArrayList<NationalPark>();

        JSONArray jo = new JSONArray(Data.Load());
        for(int i = 0; i < jo.length(); i++)
        {
            JSONObject obj = (JSONObject) jo.get(i);
            NationalPark tmp = populateParkInformation(obj);
            ret.add(tmp);
        }

        CACHE = ret;
        return ret;
    }

    private NationalPark populateParkInformation(JSONObject doc)
    {
        NationalPark np = new NationalPark();

        np.setAddress(doc.get("Address"));
        np.setCity(doc.get("City"));
        np.setFaxNumber(doc.get("Fax Number"));
        np.setLocationName(doc.get("Location Name"));
        np.setLocationNumber(doc.get("Location Number"));
        np.setPhoneNumber(doc.get("Phone Number"));
        np.setState(doc.get("State"));
        np.setZipCode(doc.get("Zip Code"));
        np.setLatitude( doc.get("Latitude") );
        np.setLongitude( doc.get("Longitude") );
        return np;
    }

    // get all the national parks
    @GET()
    @Produces("application/json")
    public List<NationalPark> getAllParks() throws Exception
    {
        return Load();

    }

    @GET
    @Produces("application/json")
    @Path("within")
    public List<NationalPark> findParksWithin(@QueryParam("lat1") float lat1, @QueryParam("lon1") float lon1, @QueryParam("lat2") float lat2, @QueryParam("lon2") float lon2)
    throws Exception
    {
        List<NationalPark> src = Load();
        List<NationalPark> ret = new ArrayList<NationalPark>();
        
        for(int i = 0; i < src.size(); i++)
        {
            NationalPark tmp = src.get(i);

            float lng = new java.math.BigDecimal( tmp.getLongitude() == null ? "0" : tmp.getLongitude().toString() ).floatValue();
            float lat = new java.math.BigDecimal( tmp.getLatitude() == null ? "0" : tmp.getLatitude().toString() ).floatValue();

            if( Float.compare(lng, lon1) > 0 ){
                continue;
            }
            if( Float.compare(lng, lon2) < 0 ){
                continue;
            }

            if( Float.compare(lat, lat1) > 0 ){
                continue;
            }
            if( Float.compare(lat, lat2) < 0 ){
                continue;
            }

            ret.add(tmp);
        }

        return ret;
    }
}
