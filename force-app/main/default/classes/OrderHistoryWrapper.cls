public class OrderHistoryWrapper{
    public String Field;
    public Id OrderId;
    public Object OldValue;
    public Object NewValue;
    public Datetime CreatedDate;

    public OrderHistoryWrapper(String field, Id orderId, Object oldValue, Object newValue, Datetime createdDate) {
        this.Field =field;
        this.OrderId =orderId;
        this.OldValue =oldValue;
        this.NewValue =newValue;
        this.CreatedDate =createdDate;
    }

    public static OrderHistoryWrapper create(String field, Id orderId, Object oldValue, Object newValue, Datetime createdDate) {
        return new OrderHistoryWrapper(field,orderId,oldValue,newValue,createdDate);
    }

    public  override String toString(){
        return JSON.serialize(this);
    }
}