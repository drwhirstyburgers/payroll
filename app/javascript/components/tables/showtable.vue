<template>
    <div class="row">
        <div class="col-md-10">
            <div class="card show-card">
                <div class="card-body">
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
                            <tr v-for="cs in reportData" v-bind:cs="cs" v-bind:key="cs.key">
                                <td>{{ cs.date }}</td>
                                <td>{{ cs.hours_worked }}</td>
                                <td>{{ cs.employee_id }}</td>
                                <td>{{ cs.job_group }}</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="col-md-2">
        </div>
    </div>
</template>

<script>
export default {
    data() {
        return {
            report: this.one_report,
            reportData: []
        }
    },
    props: ['one_report'],
    watch: {
        one_report: function() {
            const id = this.one_report.id
            $.ajax({
                type: "GET",
                url: '/get_report_data',
                data: { id: id},
                error: (err) => {
                    console.log(err)
                },
                success: (data) => {
                    this.reportData = data
                }

            })
        }
    }
}
</script>

<style scoped>
.card.show-card {
    margin-top: 3%;
}
</style>