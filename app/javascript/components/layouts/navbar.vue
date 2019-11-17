<template>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark" id="bar">
        <a class="navbar-brand" href="/">
            WayvRoll
        </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item active">
                    <a class="nav-link" href="/payroll_reports">Reports</a>
                </li>
                <li class="nav-item active">
                    <a class="nav-link" href="/job_groups">Job Groups</a>
                </li>
                <li class="nav-item active">
                    <a class="nav-link" href="/employees">Employees</a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        Create a new...
                    </a>
                    <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                        <a class="dropdown-item" href="/">Report</a>
                        <a class="dropdown-item" href="/employees/new">Employee</a>
                        <a class="dropdown-item" href="/job_groups/new">Job Group</a>
                    </div>
                </li>
            </ul>
        </div>
    </nav>
</template>

<script>
export default {
    data() {
        return{

        }
    }
}
</script>