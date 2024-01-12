public class PaginationController {
    public List<Account> accounts { get; set; }
    public Integer pageSize { get; set; }
    public Integer pageNumber { get; set; }
    public Integer totalRecords { get; set; }
    public Integer totalPages { get; set; }

    public PaginationController() {
        pageSize = 10; // Set the number of records per page
        pageNumber = 1; // Start with the first page
        updateRecords();
    }

    public void updateRecords() {
        totalRecords = [SELECT COUNT() FROM Account];
        totalPages = (totalRecords + pageSize - 1) / pageSize;

        accounts = [SELECT Name /* Add your other fields here */
                    FROM Account
                    LIMIT :pageSize OFFSET :((pageNumber - 1) * pageSize)];
    }

    public PageReference first() {
        pageNumber = 1;
        updateRecords();
        return null;
    }

    public PageReference previousPage() {
        if (pageNumber > 1) {
            pageNumber--;
            updateRecords();
        }
        return null;
    }

    public PageReference nextPage() {
        if (pageNumber < totalPages) {
            pageNumber++;
            updateRecords();
        }
        return null;
    }

    public PageReference last() {
        pageNumber = totalPages;
        updateRecords();
        return null;
    }
}
