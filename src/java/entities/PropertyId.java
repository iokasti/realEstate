package entities;
// Generated Sep 10, 2014 9:41:08 PM by Hibernate Tools 3.6.0



/**
 * PropertyId generated by hbm2java
 */
public class PropertyId  implements java.io.Serializable {


     private int propertyId;
     private int ownerUserId;

    public PropertyId() {
    }

    public PropertyId(int propertyId, int ownerUserId) {
       this.propertyId = propertyId;
       this.ownerUserId = ownerUserId;
    }
   
    public int getPropertyId() {
        return this.propertyId;
    }
    
    public void setPropertyId(int propertyId) {
        this.propertyId = propertyId;
    }
    public int getOwnerUserId() {
        return this.ownerUserId;
    }
    
    public void setOwnerUserId(int ownerUserId) {
        this.ownerUserId = ownerUserId;
    }


   public boolean equals(Object other) {
         if ( (this == other ) ) return true;
		 if ( (other == null ) ) return false;
		 if ( !(other instanceof PropertyId) ) return false;
		 PropertyId castOther = ( PropertyId ) other; 
         
		 return (this.getPropertyId()==castOther.getPropertyId())
 && (this.getOwnerUserId()==castOther.getOwnerUserId());
   }
   
   public int hashCode() {
         int result = 17;
         
         result = 37 * result + this.getPropertyId();
         result = 37 * result + this.getOwnerUserId();
         return result;
   }   


}


