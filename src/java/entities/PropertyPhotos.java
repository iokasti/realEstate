package entities;
// Generated Sep 10, 2014 9:41:08 PM by Hibernate Tools 3.6.0



/**
 * PropertyPhotos generated by hbm2java
 */
public class PropertyPhotos  implements java.io.Serializable {


     private PropertyPhotosId id;
     private Property property;
     private String path;

    public PropertyPhotos() {
    }

    public PropertyPhotos(PropertyPhotosId id, Property property, String path) {
       this.id = id;
       this.property = property;
       this.path = path;
    }
   
    public PropertyPhotosId getId() {
        return this.id;
    }
    
    public void setId(PropertyPhotosId id) {
        this.id = id;
    }
    public Property getProperty() {
        return this.property;
    }
    
    public void setProperty(Property property) {
        this.property = property;
    }
    public String getPath() {
        return this.path;
    }
    
    public void setPath(String path) {
        this.path = path;
    }




}


