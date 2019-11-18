<template>
    <div>
        <div class="input-group mb-3" id="search">
            <input v-model="reportSearch" type="text" class="form-control" placeholder="Search by report name...">
        </div>
        <ul class="list-group">
            <li v-on:click="selectReport(report)" v-for="report in filteredReports" v-bind:report="report" v-bind:key="report.key" class="list-group-item reports">
                <p class="mx-auto">{{ report.name }} - {{ moment(report.created_at).format('MMMM Do YYYY') }}</p>
            </li>
        </ul>
    </div>
</template>

<script>
export default {
    data(){
        return {
            reports: this.all_reports,
            reportSearch: '',
        }
    },
    props: ['all_reports'],
    computed: {
        filteredReports: function() {
            return this.reports.filter(r => {
                return r.name.toLowerCase().match(this.reportSearch.toLowerCase())
            })
        },
    },
    methods: {
        selectReport(report){
            console.log(report)
            const reportPicked = report
            this.$emit('selected', reportPicked)
        }
    }
}
</script>

<style scoped>
.list-group-item.reports:hover {
    background-color: lightgray;
    cursor: pointer;
}

.list-group {
    height: 95vh;
    overflow: scroll;
    overflow-x: hidden;
}

#search{
    margin-top: 8px;
    margin-left: 2px;
}
</style>