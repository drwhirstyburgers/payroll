<template>
    <table class="table">
        <thead class="thead-dark">
            <tr>
                <th scope="col">Date</th>
                <th scope="col">Hours Worked</th>
                <th scope="col">Employee ID</th>
                <th scope="col">Job Group</th>
            </tr>
        </thead>
        <tbody>
            <tr v-for="cs in submittedCsv" v-bind:cs="cs" v-bind:key="cs.key">
                <td>{{ cs.date }}</td>
                <td>{{ cs.hours_worked }}</td>
                <td>{{ cs.employee_id }}</td>
                <td>{{ cs.job_group }}</td>
            </tr>
        </tbody>
    </table>
</template>

<script>
export default {
    data() {
        return {
            csv: []
        }
    },
    props: ['submittedCsv'],
    watch: {
        submittedCsv: function () {
            this.csv = this.submittedCsv
        }
    }
}
</script>