<template>
    <ul class="list-group">
        <li v-on:click="selectReport(report)" v-for="report in reports" v-bind:report="report" v-bind:key="report.key" class="list-group-item reports">
            <p class="mx-auto">{{ report.name }} - {{ moment(report.created_at).format('MMMM Do YYYY') }}</p>
        </li>
    </ul>
</template>

<script>
export default {
    data(){
        return {
            reports: this.all_reports,
        }
    },
    props: ['all_reports'],
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
    height: 100vh;
    overflow: scroll;
    overflow-x: hidden;
}
</style>