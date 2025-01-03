@isTest
public class TestVerifyDate {

    @isTest
    static void testCheckDatesWithin30Days() {
        // Test Case: date2 is within 30 days of date1
        Date date1 = Date.today();
        Date date2 = date1.addDays(15);
        Date result = VerifyDate.CheckDates(date1, date2);
        System.assertEquals(date2, result, 'Expected date2 to be returned when it is within 30 days of date1');
    }

    @isTest
    static void testCheckDatesBeyond30Days() {
        // Test Case: date2 is beyond 30 days of date1
        Date date1 = Date.today();
        Date date2 = date1.addDays(31);
        Date expectedEndOfMonth = Date.newInstance(date1.year(), date1.month(), Date.daysInMonth(date1.year(), date1.month()));
        Date result = VerifyDate.CheckDates(date1, date2);
        System.assertEquals(expectedEndOfMonth, result, 'Expected end-of-month date to be returned when date2 is beyond 30 days of date1');
    }

    @isTest
    static void testCheckDatesPastDate2() {
        // Test Case: date2 is in the past
        Date date1 = Date.today();
        Date date2 = date1.addDays(-10);
        Date expectedEndOfMonth = Date.newInstance(date1.year(), date1.month(), Date.daysInMonth(date1.year(), date1.month()));
        Date result = VerifyDate.CheckDates(date1, date2);
        System.assertEquals(expectedEndOfMonth, result, 'Expected end-of-month date to be returned when date2 is in the past');
    }

    @isTest
    static void testEndOfMonthLogic() {
        // Test Case: Verifying end-of-month calculation
        Date date1 = Date.newInstance(2023, 2, 10); // February 2023 (non-leap year)
        Date expectedEndOfMonth = Date.newInstance(2023, 2, 28);
        Date result = VerifyDate.CheckDates(date1, date1.addDays(40)); // Force end-of-month scenario
        System.assertEquals(expectedEndOfMonth, result, 'Expected end-of-month date for February 2023');
    }
}
