<template>
    <div class="card console">
        <div class="card-body">
            <h5 v-show="report.name != null || report.name != ''" class="card-title">Report: {{ report.name }}</h5>
            <p class="card-text">Created on: {{ moment(report.created_at).format('MMMM Do YYYY') }}</p>
        </div>
    </div>
</template>

<script>
export default {
    data(){
        return {

        }
    },
    props: ['reportData']
}
</script>

<style scoped>
.card.console {
    height: 300px;
}
</style>