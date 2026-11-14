/**
 * Apex Drive - Admin Operations & Filter Utilities
 */
document.addEventListener('DOMContentLoaded', () => {
    // 1. Table Instant Search Filter
    const searchInputs = document.querySelectorAll('[data-table-search]');
    searchInputs.forEach(input => {
        const tableId = input.dataset.tableSearch;
        const table = document.getElementById(tableId);
        if (!table) return;

        input.addEventListener('keyup', () => {
            const query = input.value.toLowerCase().trim();
            const rows = table.querySelectorAll('tbody tr');

            rows.forEach(row => {
                const text = row.textContent.toLowerCase();
                row.style.display = text.includes(query) ? '' : 'none';
            });
        });
    });

    // 2. Action Confirmations
    const dangerForms = document.querySelectorAll('form[data-confirm]');
    dangerForms.forEach(form => {
        form.addEventListener('submit', (e) => {
            const msg = form.dataset.confirm || 'Are you sure you want to proceed with this action?';
            if (!confirm(msg)) {
                e.preventDefault();
            }
        });
    });
});

